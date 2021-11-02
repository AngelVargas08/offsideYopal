
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/my_app.dart';
import 'package:offside_yopal/app/ui/pages/home_user/tabs/home/map.dart';




class FavoritestabUser extends StatelessWidget {
  const FavoritestabUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
          body: OrientationBuilder(
            builder: (_,orientation) {
              if(orientation==Orientation.portrait){
                return MyMap();
              }
              return Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.red,
                )
                ),
              Expanded(
                flex: 2,
                child: MyMap(),
              )
            ],
          );
            }
            ,),



    );
  }
}