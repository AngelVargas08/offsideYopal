// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/models/cancha.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/screens/details/components/cancha_image.dart';
import 'button_details.dart';
import 'list_of_colors.dart';

var cancha1;
String? emailcan;
class Body extends StatelessWidget {
  final Cancha? cancha;
  const Body({Key? key, this.cancha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // size contine el ancho y largo del dispo
    String t = cancha!.email;
     emailcan = t;

      print(emailcan);
     if(emailcan == "minuto90@gmail.com"){
       cancha1 = "minuto90@gmail.com";
       print("dentro del if"+cancha1);
     }
    // print("Fuera del if"+cancha1);
     
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      
      bottom: false,
      child: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Center(
                    
                    child: Hero(
                      tag: '${cancha!.id}',
                      child: CanchaPoster(
                        size: size, 
                        //image: cancha!.image,
                        imgList: cancha!.imgList,
                      ),
                    ),
                  ),
                  //ListOfColors(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      cancha!.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                 
                  Padding(
                    //padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
                    padding: EdgeInsets.only(top: kDefaultPadding / 2),
                    child: Text(
                      "Horario: ${cancha!.horario}",
                      //cancha!.horario,
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                    child: Text(
                      cancha!.description,
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
            ButtonDetails(),
          ],
        ),
      ),
    );
  }
}






