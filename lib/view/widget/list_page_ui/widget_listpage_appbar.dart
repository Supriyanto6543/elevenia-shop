import 'package:flutter/material.dart';

import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../../../common/routes.dart';
import '../custom_responsive.dart';

AppBar widgetListPageAppBar(BuildContext context, Color color, String title, Function() onTap){
  return AppBar(
    toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
    title: Text(title, style:
    CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
    actions: [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: onTap,
              child: Icon(Icons.search, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              key: const Key("toCart"),
              onTap: (){
                Navigator.pushNamed(context, RoutesPage.cartPage);
              },
              child: Icon(Icons.add_shopping_cart_rounded, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30,),
            ),
          ),
        ],
      )
    ],
    backgroundColor: color,
  );
}