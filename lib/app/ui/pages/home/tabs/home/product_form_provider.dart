import 'package:flutter/material.dart';
import 'package:offside_yopal/models/models.dart';


class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKe = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);
  updateAvailability(bool value){
    
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm(){

    return formKe.currentState?.validate()?? false;
  }
}