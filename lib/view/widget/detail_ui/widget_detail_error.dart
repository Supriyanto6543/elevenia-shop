import 'package:flutter/cupertino.dart';
import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../custom_responsive.dart';

Widget detailError(BuildContext context, String message){
  return Center(
    child: Text(message, style:
    CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
  );
}