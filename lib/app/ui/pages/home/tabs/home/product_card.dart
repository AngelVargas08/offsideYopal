import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';
import 'package:offside_yopal/models/product.dart';


 var conexion = FirebaseDatabase.instance.reference();

 var admin;

class ProductCard extends StatelessWidget {
  
    final Product product;
  const ProductCard({
    Key? key,
    required this.product
    }) : super(key: key);
    
   
  @override
  Widget build(BuildContext context) {
    

     conexion.child("canchas").orderByChild('idAdmin').equalTo(globalUser).once()
     .then((DataSnapshot snapshot) {

        Map<dynamic,dynamic> map = snapshot.value;
        map.forEach((key, value) { 
             print(['------------']);
           admin = (value['idAdmin']);
        });
       
            


       /*
       print('************************');
       print(snapshot.value);
       
       var ome = snapshot.value.entries.elementAt(1).key;
          print(':::::::::::::');
          print(ome);
                        */
    });
    
    return Padding(
      
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 20),
          width: double.infinity,
          height: 400,
          decoration: _cardBorders(),
         
          child: Stack(
            alignment: Alignment.bottomLeft,
             
            children: [     
       
              _BackgroungImage(product.picture),
              _ProductDetails(
                title: product.name,
                subTitle: product.id!,
              ),
              
               Positioned(
                top: 0,
                right: 0,
                child: _PriceTag(
                  product.price
                ),
                ),
                if(!product.available)
                 Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable(),
                ),
            ],
            ),
          
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'No disponible',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
                ),
              ),
              ),
              ),
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.yellow[800],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
              ),

    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag(
    this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
          
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('\$$price',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
              ),
            ),
          ),
          width: 100,
          height : 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)
            )
          ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  
    final String title;
    final String subTitle;

  const _ProductDetails({
    required this.title,
    required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration:_buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(
              title,
                style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
              subTitle,
                style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                )
                
              ),
              
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgroungImage extends StatelessWidget {

 final String? url;
 const _BackgroungImage(this.url);
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
        child: Container(
        width: double.infinity,
        height: 400,
        child: url == null 
        ? Image(
          image: AssetImage('assets/images/dark/no-image.png'),
          fit: BoxFit.cover
          )
        : FadeInImage(
          placeholder: AssetImage('assets/images/dark/jar-loading.gif'),
          image: NetworkImage(this.url!),
          fit: BoxFit.cover,
          )
          
      ),
    );
  }
    
    
}