

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/loading_products.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/product_card.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:offside_yopal/models/models.dart';
import 'package:offside_yopal/services/products_services.dart';
import 'package:provider/provider.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';


 bool isLoading = true;
  bool isSaving = false;


class Hometab extends StatelessWidget {
  const Hometab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        ProductsServices();
      final productsService = Provider.of<ProductsServices>(context);
      if(productsService.isLoading) return LoadingScreen();

       

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        automaticallyImplyLeading: false,
      ),
      body: 
        ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
         // onTap: () => Navigator.pushNamed(context, 'product'),
           onTap: (){
             productsService.selectProduct=productsService.products[index].copy();
             router.pushNamed(Routes.PRODUCT);
           },

          child: ProductCard(
              product: productsService.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        
          onPressed: (){
            productsService.selectProduct = new Product(
              available: false, 
              name: '', 
              price: 0,
              idAdmin: globalUser,
              
              );
             router.pushNamed(Routes.PRODUCT);
          } ,
        
        ),
    );
    
    
    /*
        ),*/
      
  }

  
}