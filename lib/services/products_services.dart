
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:offside_yopal/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';

int cont =0;

class ProductsServices extends ChangeNotifier{
  final String _baseUrl = 'offside-yopal-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectProduct;

  
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsServices(){
      this.loadProduct();
      
  }
        //TODO:<List<Product>>
  Future loadProduct() async{
                
        this.isLoading = true;
        notifyListeners();
        final url = Uri.https(_baseUrl, 'canchas.json');
        final resp = await http.get(url);
        final Map<String, dynamic> productsMap = json.decode(resp.body);

        productsMap.forEach((key, value) {
            final tempProduct = Product.fromMap(value);
            tempProduct.id = key;


            if (tempProduct.idAdmin == globalUser){
                cont = cont+1;
             print('/-/-/-/-/-/-/-//-/');
              print(tempProduct.idAdmin);
                  this.products.add(tempProduct);
                  
            }
            print('___________________');
            print(cont);
  
        });

         this.isLoading = false;
        notifyListeners();
                


        return this.products;
        
        
  }
        

      Future saveOrCreateProduct(Product product)async{

        isSaving = true;
        notifyListeners();

        if (product.id == null){
              await this.createProduct(product);
        }else{
              await this.updateProduct(product);
        }
            isSaving = false;
            notifyListeners();
      }
              
                //actualizar bd
          Future<String>updateProduct(Product product)async{
            final url = Uri.https(_baseUrl, 'canchas/${ product.id}.json');
            final resp = await http.put(url, body: product.toJson());
            final decodedData = resp.body;
            final index = this.products.indexWhere((element) => element.id == product.id);
            this.products[index] = product;
            return product.id!;
          }

            //insertar dato bd
          Future<String>createProduct(Product product)async{
            final url = Uri.https(_baseUrl, 'canchas.json');
            final resp = await http.post(url, body: product.toJson());
            final decodedData = json.decode(resp.body);

           // product.idAdmin = globalUser;
            product.id = decodedData['name'];

            this.products.add(product);
            
            
            return product.id!;

       

            
          }

          void updateSelectProductImage(String path){
              this.selectProduct.picture = path;
              this.newPictureFile = File.fromUri(Uri(path: path));

              notifyListeners();
          }


          Future<String?> uploadImage()async{
               if(this.newPictureFile == null)
               return null;

               this.isSaving=true;
               notifyListeners();

               final url = Uri.parse('https://api.cloudinary.com/v1_1/ddkxoquqp/image/upload?upload_preset=rajlbutz');
               final imageUploadRequest = http.MultipartRequest('POST', url);

                final file = await http.MultipartFile.fromPath('file',newPictureFile!.path);

                imageUploadRequest.files.add(file);

                final streamResponse = await imageUploadRequest.send();
                final resp = await http.Response.fromStream(streamResponse);
                
                if(resp.statusCode !=200 && resp.statusCode !=201){
                  print('algo salio mal');
                  print(resp.body);
                  return null;
                }
                  this.newPictureFile = null;

                  final decodedData = json.decode(resp.body);
                  return decodedData['secure_url'];
                
          }

          

}