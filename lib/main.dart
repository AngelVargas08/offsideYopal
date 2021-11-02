import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:offside_yopal/app/inject_dependencies.dart';
import 'package:offside_yopal/services/products_services.dart';
import 'package:offside_yopal/services/services.dart';
import 'package:provider/provider.dart';
import 'app/my_app.dart';
import 'package:flutter_meedu/router.dart' as router;



 

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();
  router.setDefaultTransition(router.Transition.fadeIn);
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(Appstate()));
      
      
  
  
}

class Appstate extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _ )=> ProductsServices(),
          
          ),
      ] ,
      child: MyApp(),
      
      );
  }
}


/*class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<user>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data != null) {
          return HomePage();
        }
        return LoginPage();
      }
    );
  }
}
*/


