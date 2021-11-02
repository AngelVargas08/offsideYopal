import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';

class CanchaPoster extends StatelessWidget {
   const CanchaPoster({
    Key? key,
    required this.size,
    //this.image,
    this.imgList,
  }) : super(key: key);

  final Size size;
  //final String? image,image2,image3;
  final List<String>? imgList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      height: size.width * 0.7,
      //color: Colors.black,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
        ),
        items: imgList!
            .map((item) => Container(
                  child: Center(
                      child:
                          Image.network(item, fit: BoxFit.cover, width: size.width * 0.7, height:size.width * 0.7,)),
                ))
            .toList(),
      ),
    );
  }
}