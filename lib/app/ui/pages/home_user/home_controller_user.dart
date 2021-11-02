

import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class HomeControllerUser extends SimpleNotifier{
  late TabController tabControlleruser;
  HomeControllerUser(){
    tabControlleruser = TabController(
      length: 4,
       vsync: NavigatorState(),
       );
  }

  @override
  void dispose() {
   // tabControlleruser.dispose();
    super.dispose();
  }


}