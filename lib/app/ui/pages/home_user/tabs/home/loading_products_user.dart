
import 'package:flutter/material.dart';

class LoadingScreenUser extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
        ),),
    );
  }
}
