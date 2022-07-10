import 'package:flutter/cupertino.dart';
import 'package:jubelio/view/widget/custom_margin.dart';

import '../../../common/constant.dart';
import '../../../common/custom_color.dart';
import '../../../common/custom_currency.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../../../common/routes.dart';
import '../../../model/model_product_list.dart';
import '../check_stock.dart';
import '../custom_responsive.dart';

Widget widgetListPageBody(BuildContext context, ModelProductList mpl, Function() onTap){
  return GestureDetector(
    key: const Key("toDetailPage"),
    onTap: onTap,
    child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColor.boxDecoration
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${Constant.widgetProductName} ${mpl.prdNm}', style:
            CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
            customSizedBox(CustomSize.f5, CustomSize.f0),
            Text('${Constant.widgetHarga} ${CustomCurrency.convertIdr(mpl.selPrc!)}', style:
            CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
            customSizedBox(CustomSize.f5, CustomSize.f0),
            Text('${Constant.widgetQty} ${mpl.prdSelQty}', style:
            CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
            customSizedBox(CustomSize.f5, CustomSize.f0),
            checkStock(mpl, context),
          ],
        )
    ),
  );
}