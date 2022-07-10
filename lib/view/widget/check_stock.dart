import 'package:flutter/cupertino.dart';
import '../../common/custom_color.dart';
import '../../common/custom_font.dart';
import '../../common/custom_size.dart';
import '../../model/model_product_list.dart';
import 'custom_responsive.dart';

checkStock(ModelProductList mpl, BuildContext context){
  if(mpl.selMthdCd == "01"){
    return Text('Status: Ready Stock', style:
    CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),);
  }else if(mpl.selMthdCd == "04"){
    return Text('Status: Pre-Order', style:
    CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),);
  }else if(mpl.selMthdCd == "05"){
    return Text('Status: Used Items', style:
    CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),);
  }
}