import 'package:flutter/material.dart';
import 'package:offside_yopal/models/models.dart';


class ProductFormProviderUser extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProviderUser(this.product);
  updateAvailability(bool value){
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm(){

    return formKey.currentState?.validate()?? false;
  }
}