import 'package:flutter/cupertino.dart';
import 'package:jubelio/common/custom_color.dart';
import 'package:jubelio/common/custom_font.dart';

import '../../common/custom_size.dart';
import 'custom_responsive.dart';

Widget customNotFound(String title, BuildContext context){
  return Container(
    color: CustomColor.transparent,
    child: Center(
      child: Text(title, style:
        CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
    ),
  );
}