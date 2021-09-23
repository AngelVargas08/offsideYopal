
import 'dart:async';
import 'dart:io';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offside_yopal/app/domain/repositories/autenticacion_repositorio.dart';
import 'package:offside_yopal/app/domain/responses/reset_password_response.dart';
import 'package:offside_yopal/app/domain/responses/sign_in_response_.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_meedu/router.dart' as router;



var globalUser;

class AuthenticationRepositoryImpl implements AuthenticationRepository{

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  User? _user;

  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required FacebookAuth facebookAuth,
  }): _auth = firebaseAuth,
   _googleSignIn = googleSignIn,
   _facebookAuth = facebookAuth
   {
    
    _init();
    
  }

  @override
  Future<User?> get user async {
   await _completer.future;
    return _user;
  }

  void _init() async{
    _auth.authStateChanges().listen(
      (User? user) { 
        if(!_completer.isCompleted){ 
          _completer.complete();
        }
        _user = user;
        UserHelper.saveuser(_user!);
        // print(_user);

        var x = _user!.email;
        globalUser = x;

           FirebaseFirestore.instance.collection('users').where('email', isEqualTo: globalUser )
            .snapshots().listen((salida) {
              
              salida.docs.forEach((usuarios) {
              
                if(usuarios["role"] == "admin"){  
                    router.pushReplacementNamed(Routes.HOME);
                  
            } 
            else{
              
               router.pushReplacementNamed(Routes.HOMEUSER);
            }
              });
            });
            
            


       
      }

      );
      
  }

  @override
  Future<void> signOut() async{
    final data = _user?.providerData ?? [];
    String providerId = 'firesbase';
    for(final provider in data){
      // password
      //phone
      //google.com
      //facebook.com
      //twitter.com
      
        if(provider.providerId !='firesbase'){
          providerId =provider.providerId;
          break;
        }
    }
    if(providerId=='google.com'){
      _googleSignIn.signOut();
    } else if(providerId == 'facebook.com'){
     await _facebookAuth.logOut();
    }
    return _auth.signOut();
  }

  @override
  Future<SingInResponse> signInWithEmailAnfPassword(String email, String password) async{
    
    try{
      final metodos = await _auth.fetchSignInMethodsForEmail(email);
      if(metodos.isNotEmpty && !metodos.contains('password')){
        return SingInResponse(
          error: SignInError.accoutExistsWithDifferentCredential, 
          user: null,
           providerId: metodos.first,
           );
      }
    
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
        );
        final user = userCredential.user!;
        return SingInResponse(
          user: user,
          providerId:userCredential.credential?.providerId,
           error: null,
           );
    }on FirebaseAuthException catch(e){
        return getSignInError(e);
    }
  }

  @override
  Future<ResetPasswordResponse> sendResetPasswordLink(String email)async{
        try{
        await  _checkAuthProvider(
            email: email, 
            signInMethod: 'password'
            );
          await  _auth.sendPasswordResetEmail(email: email);
            return ResetPasswordResponse.ok;
        }on FirebaseAuthException catch(e){
         return StringToResetPasswordResponse(e.code);

        }
   }

  @override
  Future<SingInResponse> signInWithGoogle() async{
    try{
     final account = await _googleSignIn.signIn();
     if (account == null){
        return SingInResponse(
         error : SignInError.cancelled,
         user: null,
         providerId: null,
         );
     }

     await _checkAuthProvider(
       email: account.email,
        signInMethod: 'google.com'
        );

     final googleAuth = await account.authentication;
     final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
      return _signInWithCredential(oAuthCredential);
    }on FirebaseAuthException catch(e){
      
     return getSignInError(e);
    }
  }

  @override
  Future<SingInResponse> signInWithFacebook() async {
     
      try{
       final result = await _facebookAuth.login();
      if(result.status==LoginStatus.success){
       final userData = await _facebookAuth.getUserData();
       final email = userData['email'] as String?;
       if(email != null){
        
         await _checkAuthProvider(
           email: email, 
           signInMethod: 'facebook.com'
           );
       }
       

       final oAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        return _signInWithCredential(oAuthCredential);
      }
          else if(result.status ==LoginStatus.cancelled){
        return SingInResponse(
         error : SignInError.cancelled,
         user: null,
         providerId: null,
         );
          }
          return SingInResponse(
         error : SignInError.unknown,
         user: null,
         providerId: null,
         );
       
    
      
    }on FirebaseAuthException catch(e){
         
     return getSignInError(e);
    }

   
  }

  Future<SingInResponse>_signInWithCredential(AuthCredential oAuthCredential)async{
   
    final userCredential = await _auth.signInWithCredential(
        oAuthCredential,
      );
      final user = userCredential.user!;
      if(!user.emailVerified && user.email!=null){
        await user.sendEmailVerification();
      }
      return SingInResponse(
        error: null,
        user:user,
        providerId:userCredential.credential?.providerId,
         );
    
  }

    Future<void>_checkAuthProvider({
      required String email, 
      required String signInMethod,
      })async {
           final methods = await _auth.fetchSignInMethodsForEmail(email);
        if(methods.isNotEmpty && !methods.contains(signInMethod)){
          if(signInMethod=='facebook.com'){
            
           await _facebookAuth.logOut();
          }else if(signInMethod == 'google.com'){
             await _googleSignIn.signOut();
          }
          throw FirebaseAuthException(
            code: "account-exists-with-different-credential",
            credential: AuthCredential(
              providerId: methods.first,
              signInMethod: signInMethod
              ),
            );
        
      }
                  
      }

}




      //guardar user db UserHelper.saveUser(snapshot.data)
  class UserHelper{
      
     static FirebaseFirestore _db = FirebaseFirestore.instance;
     static saveuser(User user)async{
       PackageInfo packageInfo = await PackageInfo.fromPlatform();
       int buildNumber = int.parse(packageInfo.buildNumber);
       Map<String,dynamic> userData = {
         "name" : user.displayName,
          "email" : user.email,
          "last_login" : user.metadata.lastSignInTime,
          "created_at" : user.metadata.lastSignInTime,
          "role" : "user",
         "build_number" : buildNumber
         
       };
      

        final userRef = _db.collection("users").doc(user.uid);
          if((await userRef.get()).exists){
            await userRef.update({
              "last_login" : user.metadata.lastSignInTime,
              "build_number" :buildNumber,
            });
          }else{
            await userRef.set(userData);
          }
          await _saveDevice(user);
  }
    static _saveDevice(User user)async{
        DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
        String deviceId="";
        Map<String,dynamic>deviceData;
        if(Platform.isAndroid){
          final deviceInfo = await devicePlugin.androidInfo;
          deviceId = deviceInfo.androidId;
          deviceData={
            "os_version": deviceInfo.version.sdkInt.toString(),
            "platform":"android",
            "model": deviceInfo.model,
            "device":deviceInfo.device
          };
        }

        if(Platform.isIOS){
          final deviceInfo = await devicePlugin.iosInfo;
          deviceId = deviceInfo.identifierForVendor;
          deviceData={
            "os_version": deviceInfo.systemVersion,
            "platform":"ios",
            "model": deviceInfo.model,
            "device":deviceInfo.name
        };
    }
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final deviceRef = _db.collection("users").doc(user.uid).collection("devices").doc(deviceId);

    if((await deviceRef.get()).exists){
      await deviceRef.update({
        "update_at":nowMs,
        "uninstalled":false,
      });
    }else{
      await deviceRef.set({
        "created_at":nowMs,
        "updated_at":nowMs,
        "uninstalled": false,
        "id":deviceId,
        
      });
    }
  }

   
     
  }
  
