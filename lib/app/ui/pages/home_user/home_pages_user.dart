

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/profile/profile_tab.dart';
import 'package:offside_yopal/app/ui/pages/home_user/tabs/favorites/favorites_tab_user.dart';
import 'package:offside_yopal/app/ui/pages/home_user/tabs/home/home_tab_user.dart';
import 'package:offside_yopal/app/ui/pages/home_user/tabs/notifications/notifications_tab_user.dart';
import 'package:offside_yopal/app/ui/pages/home_user/widgets/home_tab_bar_user.dart';
import 'home_controller_user.dart';


final homeProvideruser = SimpleProvider(
  (_) => HomeControllerUser(),
);

class HomePageUser extends StatelessWidget {
  const HomePageUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   return ProviderListener<HomeControllerUser>(
      provider: homeProvideruser,
      builder: (_,controller){
       return   Scaffold(
         bottomNavigationBar: HomeTabBarUser(),
      body: SafeArea(
        child: TabBarView(
          controller: controller.tabControlleruser,
          children: const [
    
           HometabUser(),
           FavoritestabUser(),
            NotifitabUser(),
            ProfileTab(),
            
          ],
          ),
          ),
    );
      },
    );

    
  }
}