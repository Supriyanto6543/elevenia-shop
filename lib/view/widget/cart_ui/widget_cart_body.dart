import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jubelio/common/constant.dart';
import 'package:jubelio/common/custom_currency.dart';
import 'package:jubelio/view/widget/custom_margin.dart';
import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../../../common/routes.dart';
import '../../../model/model_product_detail.dart';
import '../custom_responsive.dart';

Widget widgetCartBody(BuildContext context, ModelProductDetail mpl){
  return GestureDetector(
    onTap: (){
      Navigator.pushNamed(context, RoutesPage.detailPage,
          arguments: {'prdNo': mpl.prdNo});
    },
    child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColor.boxDecoration
        ),
        child: Row(
          children: [
            mpl.prdImage01 != null ? Image.network('${mpl.prdImage01}',
              width: 60, height: 100,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 100,
                  width: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ?
                      loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, exception, stackTrace){
                return Image.asset('assets/images/img_not_available.jpeg',
                  height: 100,
                  fit: BoxFit.cover,
                  width: 60);
              },
            ) : Image.asset('assets/images/img_not_available.jpeg',
                  width: 60, height: 100,
                  fit: BoxFit.cover,),
            customSizedBox(CustomSize.f0, CustomSize.f15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Constant.widgetProductName} ${mpl.prdNm}', style:
                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                  customSizedBox(CustomSize.f5, CustomSize.f0),
                  Text('${Constant.widgetHarga} ${CustomCurrency.convertIdr(mpl.selPrc!)}', style:
                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                  customSizedBox(CustomSize.f5, CustomSize.f0),
                  Text('${Constant.prdno} ${mpl.prdNo}', style:
                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                ],
              ),
            )
          ],
        )
    ),
  );
}