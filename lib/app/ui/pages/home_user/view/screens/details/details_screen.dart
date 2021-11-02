import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/models/cancha.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Cancha? cancha;
  const DetailsScreen({Key? key, this.cancha}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(
        cancha: cancha,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/images/user/icons/back.svg"), 
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        ''.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/images/user/icons/location.svg"),
          onPressed: (){
                     router.pushNamed(Routes.MYMAP);
            
          }, 
        ),
      ],
    );
  }
}