// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/screens/cancha/components/cancha_card.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/pages/home_user/view/models/cancha.dart';

import '../../../constants.dart';
class ButtonDetails extends StatelessWidget {
   final Cancha? cancha;
  const ButtonDetails({
    Key? key, this.cancha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding/ 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          //Spacer(),
          FlatButton.icon(
            onPressed: (){
                 router.pushNamed(Routes.PRODUCTUSER);
                
            }, 
            icon: SvgPicture.asset(
              "assets/images/user/icons/shopping-bag.svg",
              height: 22,
            ),
            label: Text(
              "Reservar", 
              style: TextStyle(color:Colors.white,fontSize: 15),
              
            ),
          ),
        ],
      ),
    );
  }
}
