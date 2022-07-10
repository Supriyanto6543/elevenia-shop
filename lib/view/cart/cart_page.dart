import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:jubelio/common/constant.dart';
import 'package:jubelio/controller/cart/cart_cubit.dart';
import 'package:jubelio/model/model_product_detail.dart';
import 'package:jubelio/view/widget/cart_ui/widget_cart_appbar.dart';
import 'package:jubelio/view/widget/cart_ui/widget_cart_body.dart';
import 'package:jubelio/view/widget/custom_loading.dart';
import 'package:jubelio/view/widget/custom_not_found.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/custom_color.dart';
import '../../common/custom_font.dart';
import '../../common/custom_size.dart';
import '../../common/routes.dart';
import '../widget/custom_responsive.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      online: Scaffold(
        appBar: widgetCartAppBar(context, CustomColor.blueColor, Constant.widgetCartTitleOnline),
        body: BlocProvider(create: (_)=>CartCubit()..getOfflineCart(),
          child: BlocBuilder<CartCubit, CartState>(builder: (context, state){
            if(state is CartLoaded){
              if(state.list.isNotEmpty){
                return SmartRefresher(
                  controller: CartCubit.refresher,
                  enablePullDown: true,
                  onRefresh: context.read<CartCubit>().onRefresh,
                  child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, i){
                        ModelProductDetail mpl = state.list[i];
                        return widgetCartBody(context, mpl);
                      }
                  ),
                );
              }else{
                return customNotFound(Constant.widgetCartNoItem, context);
              }
            }
            return customLoading();
          }),
        ),
      ),
      offline: Scaffold(
        appBar: widgetCartAppBar(context, CustomColor.grey, Constant.widgetCartTitleOffline),
        body: BlocProvider(create: (_)=>CartCubit()..getOfflineCart(),
          child: BlocBuilder<CartCubit, CartState>(builder: (context, state){
            if(state is CartLoaded){
              if(state.list.isNotEmpty){
                return SmartRefresher(
                  controller: CartCubit.refresher,
                  enablePullDown: true,
                  onRefresh: context.read<CartCubit>().onRefresh,
                  child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, i){
                        ModelProductDetail mpl = state.list[i];
                        return widgetCartBody(context, mpl);
                      }
                  ),
                );
              }else{
                return customNotFound(Constant.widgetCartNoItem, context);
              }
            }
            return customLoading();
          }),
        ),
      )
    );
  }
}
