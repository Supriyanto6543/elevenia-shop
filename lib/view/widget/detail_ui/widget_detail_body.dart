import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../common/custom_color.dart';
import '../../../common/custom_currency.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../../../controller/product_detail/product_detail_cubit.dart';
import '../custom_responsive.dart';

Widget widgetDetailBody(BuildContext context, ProductDetailLoaded state){
  var detail = state.modelProductDetail.htmlDetail!.replaceAll("\\r\\\\n", " ");
  return Container(
    color: CustomColor.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        state.modelProductDetail.prdImage01 != null ? Image.network('${state.modelProductDetail.prdImage01}',
          height: 200,
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: 200,
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
            return Image.asset('assets/images/img_not_available.jpeg', height: 200,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,);
          },) : Image.asset('assets/images/img_not_available.jpeg',
          height: 200,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
          child: Text(CustomCurrency.convertIdr(state.modelProductDetail.selPrc!), style:
          CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f30),),
        ),
        Html(
            style: {
              "body": Style(
                fontSize: FontSize(!tablet(context) ? CustomSize.f20 : CustomSize.f30),
              )
            },
            data: detail.replaceAll("\\\\n", "")),
      ],
    ),
  );
}