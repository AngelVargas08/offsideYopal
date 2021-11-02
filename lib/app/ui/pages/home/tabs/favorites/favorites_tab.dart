
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;




class Favoritestab extends StatelessWidget {
  const Favoritestab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        automaticallyImplyLeading: false,
      ),
     
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        
          onPressed: (){
             router.pushNamed(Routes.CALENDAR);
          } ,
        
        ),
    );
  }
}