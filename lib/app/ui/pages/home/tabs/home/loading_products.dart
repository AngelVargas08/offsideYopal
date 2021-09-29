
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/home/home_tab.dart';

class LoadingScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    isLoading = true;
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
