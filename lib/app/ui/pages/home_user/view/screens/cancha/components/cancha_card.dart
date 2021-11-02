// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/models/cancha.dart';

import '../../../constants.dart';

class CanchaCard extends StatelessWidget {
  const CanchaCard({
    Key? key,
    this.itemIndex, 
    this.cancha,
    this.press,
  }) : super(key: key);

  final int? itemIndex;
  final Cancha? cancha;
  final Function()? press;
  
  @override
  Widget build(BuildContext context) {
   // s = cancha!.email;
    Size size = MediaQuery.of(context).size;
     
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
        
      ),
      
      //color: Colors.blueAccent,
      height: 160,
      
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex!.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            //imagen de la cancha
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '${cancha!.id}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 160,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90.0),
                    child: Image.network(
                      cancha!.imgList[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            //nombre cancha y precio
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Text(
                        cancha!.title, 
                        style: Theme.of(context).textTheme.button,
                        
                      ),
                    
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding* 1.5,
                        vertical: kDefaultPadding / 4
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        
                        cancha!.price.toString(),
                        style: Theme.of(context).textTheme.button,
                      ),
                      
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}