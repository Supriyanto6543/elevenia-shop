import 'package:flutter/cupertino.dart';

import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../../../controller/search/search_cubit.dart';
import '../custom_responsive.dart';

Widget sortingName(BuildContext context, String name, Function() function){
  return GestureDetector(
    onTap: function,
    child: Container(
      decoration: BoxDecoration(
        color: CustomColor.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: CustomColor.black
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
        child: Text(name, style:
        CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f27)),
      ),
    ),
  );
}