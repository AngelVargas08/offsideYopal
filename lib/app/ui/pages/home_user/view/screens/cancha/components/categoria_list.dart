import 'package:flutter/material.dart';

import '../../../constants.dart';

class TipoCanchas extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TipoCanchas({Key? key}) : super(key: key);

  @override
  _TipoCanchasState createState() => _TipoCanchasState();
}

class _TipoCanchasState extends State<TipoCanchas> {
  int selectedIndex = 0;
  List categorias = ['Fútbol 5', 'Fútbol 7', 'Fútbol 9', 'Fútbol 11'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: (){
            setState(() {
              
              selectedIndex = index;
              print(selectedIndex);
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding,
              right: index == categorias.length -1 ? kDefaultPadding: 0
            ),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            
            child: Text(
              categorias[index],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}