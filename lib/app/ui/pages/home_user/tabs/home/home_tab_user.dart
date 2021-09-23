

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/loading_products.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/product_card.dart';
import 'package:flutter_meedu/router.dart' as router;
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
      appBar: AppBar(
        title: Text('User'),
        automaticallyImplyLeading: false,
      ),
    );
    
    
    /*
        ),*/
      
  }

  
}