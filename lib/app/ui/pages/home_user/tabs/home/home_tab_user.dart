

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/loading_products.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/product_card.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/pages/home_user/tabs/home/map.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/screens/cancha/canchas_screen.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:offside_yopal/models/models.dart';
import 'package:offside_yopal/services/products_services.dart';
import 'package:provider/provider.dart';


class HometabUser extends StatelessWidget {
  const HometabUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      final productsService = Provider.of<ProductsServices>(context);
      if(productsService.isLoading) return LoadingScreen();

     

    return Scaffold(
      
          body: OrientationBuilder(
            builder: (_,orientation) {
              if(orientation==Orientation.portrait){
                return CanchasScreen();
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
    
    
    /*
        ),*/
      
  }

  
}