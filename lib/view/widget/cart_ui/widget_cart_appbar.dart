import 'package:flutter/material.dart';
import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../custom_responsive.dart';

AppBar widgetCartAppBar(BuildContext context, Color color, String title){
  return AppBar(
    toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
    title: Text(title, style:
    CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
    backgroundColor: color,
  );
}