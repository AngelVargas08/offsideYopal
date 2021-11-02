
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/global_widgets/product_screen.dart';
import 'package:offside_yopal/app/ui/pages/home/home_pages.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/add_event.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/calendar.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/event_details.dart';
import 'package:offside_yopal/app/ui/pages/home_user/home_pages_user.dart';
import 'package:offside_yopal/app/ui/pages/home_user/tabs/home/map.dart';
import 'package:offside_yopal/app/ui/pages/home_user/tabs/home/products_user.dart';
import 'package:offside_yopal/app/ui/pages/login/login_page.dart';
import 'package:offside_yopal/app/ui/pages/register/widgets/register_page.dart';
import 'package:offside_yopal/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:offside_yopal/app/ui/pages/splash/splash_page.dart';
import 'routes.dart';


Map<String, Widget Function(BuildContext)>  appRoutes(settings) => {

      
  
  Routes.SPLASH:(_)=> const SplashPage(),
  Routes.LOGIN:(_)=> const LoginPage(),
  Routes.HOME:(_)=> const HomePage(),
  Routes.HOMEUSER:(_)=> const HomePageUser(),
  Routes.PRODUCT:(_)=>  ProductScreen(),
  Routes.REGISTER:(_)=> const RegisterPage(),
  Routes.RESET_PASSWORD:(_)=> const ResetPasswordPage(),
  Routes.CALENDAR:(_)=>  Calendar(),
  Routes.ADDEVENT:(_)=>  const AddEvent(),
  Routes.MYMAP:(_)=>  const MyMap(),
  Routes.EVENTDETAILS:(_)=>   EventDetails(),
  Routes.PRODUCTUSER:(_)=>   HometabUSer(),


   

};



    
