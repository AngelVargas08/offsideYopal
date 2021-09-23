
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:offside_yopal/app/ui/global_widgets/product_Image.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/product_form_provider.dart';
import 'package:offside_yopal/services/products_services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsServices>(context);

    return  ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider(productService.selectProduct),
      child: _ProductsScreenBody(productService: productService),
      );
    
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsServices productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                  ProductImage( url: productService.selectProduct.picture ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      onPressed: () =>Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.white ,)
                  )
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    
                    child: IconButton(
                      onPressed: () async{
                          final picker = new  ImagePicker();                         
                          final PickedFile? pickedFile = await picker.getImage(
                           
                            source: ImageSource.camera,
                            imageQuality: 100
                            );

                            if(pickedFile == null){
                              print('No selecciono nada');
                              return;
                            }
                            print('Tenemos imagen ${pickedFile.path}');
                            productService.updateSelectProductImage(pickedFile.path);
                      },
                      icon: Icon(Icons.camera_alt_outlined, size: 30, color: Colors.white ,)
                  )
                  ),
                  Positioned(
                    top: 100,
                    right: 20,
                    child: IconButton(
                      onPressed: () async{
                          final picker = new  ImagePicker();
                          final PickedFile? pickedFile = await picker.getImage(
                            source: ImageSource.gallery,                           
                            imageQuality: 100
                            );

                            if(pickedFile == null){
                              print('No selecciono nada');
                              return;
                            }
                            print('Tenemos imagen ${pickedFile.path}');
                            productService.updateSelectProductImage(pickedFile.path);
                      },
                      icon: Icon(Icons.photo, size: 30, color: Colors.white ,)
                  )
                  )
                  ],
            ),
              _ProductForm(),
              SizedBox(height: 100),

          ],
          
          
          )
        ),
       // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: productService.isSaving
          ? CircularProgressIndicator(color: Colors.white,)
          : Icon(Icons.save_outlined),
          onPressed: productService.isSaving
          ? null
          : ()async{
              if (!productForm.isValidForm()) return;

              final String? imageUrl = await productService.uploadImage();

                  if (imageUrl != null) productForm.product.picture = imageUrl;

              await productService.saveOrCreateProduct(productForm.product);
          },
          ),
      );
  }
}

class _ProductForm extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildboxDecoration(),
        child: Form(
          key: productForm.formKe,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children:  [
               SizedBox(height: 10),
              TextFormField(
               
                autofocus: false,
                initialValue: product.name,
                onChanged: (value) => product.name =value,
                validator: (value){
                  if(value==null || value.length <1)
                  return 'El nombre es obligatorio';
                },
                decoration: InputDecoration(
                hintText: 'Nombre de la cancha',
                labelText: 'Nombre'
                ),
                ),
              SizedBox(height: 30,),

              TextFormField(
               
                autofocus: false,
                initialValue: '${product.price}',
                inputFormatters:[
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}'))
                ],
                onChanged: (value){
                    if(double.tryParse(value)==null){
                      product.price = 0;
                    }else{
                        product.price =double.parse(value);
                    }
                   
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                hintText: '\$999',
                labelText: 'Precio'
                ),
                ),
                SizedBox(height: 30,),
                SwitchListTile.adaptive(
                  value: product.available, 
                  title: Text('Disponible'),
                  activeColor: Colors.pink,
                  onChanged: productForm.updateAvailability
                  ),
                  SizedBox(height: 30,),
            ],
            )
            ),
      ),
    );
  }

  BoxDecoration _buildboxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0,05),
        blurRadius: 5,
      )
    ]
  );
}