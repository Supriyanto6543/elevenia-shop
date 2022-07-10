import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:jubelio/common/custom_color.dart';
import 'package:jubelio/common/custom_currency.dart';
import 'package:jubelio/common/custom_font.dart';
import 'package:jubelio/common/custom_size.dart';
import 'package:jubelio/controller/product_detail/product_detail_cubit.dart';
import 'package:jubelio/view/widget/custom_loading.dart';
import 'package:jubelio/view/widget/custom_responsive.dart';
import 'package:jubelio/view/widget/detail_ui/widget_detail_appbar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.prdNo}) : super(key: key);

  final String? prdNo;

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      online: BlocProvider<ProductDetailCubit>(
        create: (_)=>ProductDetailCubit()..getProductDetail(prdNo!),
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state){
            if(state is ProductDetailLoaded){
              var detail = state.modelProductDetail.htmlDetail!.replaceAll("\\r\\\\n", " ");
              return Scaffold(
                key: ProductDetailCubit.scaffold,
                appBar: widgetDetailAppBar(context, state.modelProductDetail.prdNm!, () =>
                    context.read<ProductDetailCubit>().addToCart(state.modelProductDetail)),
                backgroundColor: CustomColor.white,
                body: SingleChildScrollView(
                  child: Container(
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
                  ),
                ),
              );
            }
            if(state is ProductDetailError){
              return Scaffold(
                key: ProductDetailCubit.scaffold,
                appBar: widgetDetailAppBar(context, state.message, () => null),
                backgroundColor: CustomColor.white,
                body: Center(
                  child: Text(state.message, style:
                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                ),
              );
            }
            return customLoading();
          }
        ),
      ),
      offline: BlocProvider<ProductDetailCubit>(
        create: (_)=>ProductDetailCubit()..getProductDetailOffline(prdNo!),
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state){
              if(state is ProductDetailLoaded){
                var detail = state.modelProductDetail.htmlDetail!.replaceAll("\\r\\\\n", " ");
                return Scaffold(
                  key: ProductDetailCubit.scaffold,
                  appBar: widgetDetailAppBar(context, state.modelProductDetail.prdNm!, () =>
                      context.read<ProductDetailCubit>().addToCart(state.modelProductDetail)),
                  backgroundColor: CustomColor.white,
                  body: SingleChildScrollView(
                    child: Container(
                      color: CustomColor.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/img_not_available.jpeg',
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
                    ),
                  ),
                );
              }
              if(state is ProductDetailError){
                return Scaffold(
                  key: ProductDetailCubit.scaffold,
                  appBar: widgetDetailAppBar(context, state.message, () => null),
                  backgroundColor: CustomColor.white,
                  body: Center(
                    child: Text(state.message, style:
                    CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                  ),
                );
              }
              return customLoading();
            }
        ),
      ),
    );
  }
}
