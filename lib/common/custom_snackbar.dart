import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jubelio/common/custom_color.dart';
import 'package:jubelio/common/custom_font.dart';
import 'package:jubelio/common/custom_size.dart';

displaySnackbar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(content,
          style: CustomFont.fontTitleCard(
              CustomColor.white,
              CustomSize.f19),)),
  );
}