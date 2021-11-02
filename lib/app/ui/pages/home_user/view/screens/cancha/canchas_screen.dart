import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/screens/cancha/components/body.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;

class CanchasScreen extends StatelessWidget {
  const CanchasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
       title: Row(
         
        mainAxisAlignment: MainAxisAlignment.start,
         children: [
            
           Image.asset('assets/images/user/icons/logo.png', fit: BoxFit.cover, height: 150
           ),  
         ],
       ),
      centerTitle: false,
      actions: <Widget>[IconButton(
        onPressed: (){
          router.pushNamed(Routes.MYMAP);
        },   
        icon: SvgPicture.asset("assets/images/user/icons/notification.svg"))],
    );
  }
}