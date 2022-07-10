import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../../../controller/product_detail/product_detail_cubit.dart';
import '../custom_responsive.dart';

AppBar widgetDetailAppBar(BuildContext context, String state, Function() onTap){
  return AppBar(
    toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
    title: Text(state, style:
    CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
    actions: [
      GestureDetector(
          onTap: onTap,
          child: Container(
            key: const Key("hello"),
            margin: const EdgeInsets.only(right: 10),
            child: Icon(Icons.add_shopping_cart_rounded, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30,),
          )
      )
    ],
  );
}