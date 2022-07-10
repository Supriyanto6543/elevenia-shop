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
import 'package:jubelio/view/widget/detail_ui/widget_detail_body.dart';
import 'package:jubelio/view/widget/detail_ui/widget_detail_error.dart';

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
              return Scaffold(
                key: ProductDetailCubit.scaffold,
                appBar: widgetDetailAppBar(context, state.modelProductDetail.prdNm!, () =>
                    context.read<ProductDetailCubit>().addToCart(state.modelProductDetail)),
                backgroundColor: CustomColor.white,
                body: SingleChildScrollView(
                  child: widgetDetailBody(context, state),
                ),
              );
            }
            if(state is ProductDetailError){
              return Scaffold(
                key: ProductDetailCubit.scaffold,
                appBar: widgetDetailAppBar(context, state.message, () => null),
                backgroundColor: CustomColor.white,
                body: detailError(context, state.message),
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
                return Scaffold(
                  key: ProductDetailCubit.scaffold,
                  appBar: widgetDetailAppBar(context, state.modelProductDetail.prdNm!, () =>
                      context.read<ProductDetailCubit>().addToCart(state.modelProductDetail)),
                  backgroundColor: CustomColor.white,
                  body: SingleChildScrollView(
                    child: widgetDetailBody(context, state),
                  ),
                );
              }
              if(state is ProductDetailError){
                return Scaffold(
                  key: ProductDetailCubit.scaffold,
                  appBar: widgetDetailAppBar(context, state.message, () => null),
                  backgroundColor: CustomColor.white,
                  body: detailError(context, state.message)
                );
              }
              return customLoading();
            }
        ),
      ),
    );
  }
}
