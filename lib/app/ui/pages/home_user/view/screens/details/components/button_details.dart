// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/screens/cancha/components/cancha_card.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/pages/home_user/view/models/cancha.dart';
import 'package:offside_yopal/services/products_services.dart';
import '../../../constants.dart';


var colo1 = Color(0xFFFCBF1E);
var desc = 'Reservar';
class ButtonDetails extends StatelessWidget {
   final Cancha? cancha;
  const ButtonDetails({
    Key? key, this.cancha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('segundavuelta');
    print(emailcan);
    

    if('canchamaracana@gmail.com'!= emailcan){
      colo1 = Color(0xFFFF3333);
      desc = 'No disponible';
    }
    if('canchamaracana@gmail.com'== emailcan){
      colo1 = Color(0xFFFCBF1E);
      desc = 'Reservar';
    }
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding/ 2,
      ),
      decoration: BoxDecoration(
        
        color: colo1,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          //Spacer(),
          FlatButton.icon(
            onPressed: (){
              if('canchamaracana@gmail.com' == emailcan){
                       router.pushNamed(Routes.PRODUCTUSER);
                  }
                
                
            }, 
            icon: SvgPicture.asset(
              "assets/images/user/icons/shopping-bag.svg",
              height: 22,
            ),
            label: Text(
              desc, 
              style: TextStyle(color:Colors.white,fontSize: 15),
              
            ),
          ),
        ],
      ),
    );
  }
}
