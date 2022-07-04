import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:jubelio/controller/cart/cart_cubit.dart';
import 'package:jubelio/model/model_product_detail.dart';
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
        appBar: AppBar(
          toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
          title: Text('Cart Page - Mode Online', style:
          CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
        ),
        body: BlocProvider(create: (_)=>CartCubit()..getOfflineCart(),
          child: BlocBuilder<CartCubit, CartState>(builder: (context, state){
            if(state is CartLoaded){
              if(state.list.isNotEmpty){
                return SmartRefresher(
                  controller: CartCubit.refresher,
                  enablePullDown: true,
                  //enablePullUp: true,
                  onRefresh: context.read<CartCubit>().onRefresh,
                  //onLoading: context.read<ProductListCubit>().onLoadMore,
                  child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, i){
                        ModelProductDetail mpl = state.list[i];
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama Product: ${mpl.prdNm}', style:
                                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                                  const SizedBox(height: 4,),
                                  Text('Harga: ${mpl.selPrc}', style:
                                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                                  const SizedBox(height: 4,),
                                  Text('No Id: ${mpl.prdNo}', style:
                                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                                ],
                              )
                          ),
                        );
                      }
                  ),
                );
              }else{
                return Center(
                  child: Text('Item mu akan muncul disini', style:
                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                );
              }
            }
            return Center(
              child: Container(
                color: Colors.transparent,
                child: const CircularProgressIndicator(),
                height: 50, width: 50,
              ),
            );
          }),
        ),
      ),
      offline: Scaffold(
        appBar: AppBar(
          toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
          title: Text('Cart Page - Offline Mode', style:
            CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
          backgroundColor: CustomColor.grey,
        ),
        body: BlocProvider(create: (_)=>CartCubit()..getOfflineCart(),
          child: BlocBuilder<CartCubit, CartState>(builder: (context, state){
            if(state is CartLoaded){
              if(state.list.isNotEmpty){
                return SmartRefresher(
                  controller: CartCubit.refresher,
                  enablePullDown: true,
                  //enablePullUp: true,
                  onRefresh: context.read<CartCubit>().onRefresh,
                  //onLoading: context.read<ProductListCubit>().onLoadMore,
                  child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, i){
                        ModelProductDetail mpl = state.list[i];
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama Product: ${mpl.prdNm}', style:
                                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                                  const SizedBox(height: 4,),
                                  Text('Harga: ${mpl.selPrc}', style:
                                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                                  const SizedBox(height: 4,),
                                  Text('No Id: ${mpl.prdNo}', style:
                                  CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                                ],
                              )
                          ),
                        );
                      }
                  ),
                );
              }else{
                return Center(
                  child: Text('Item mu akan muncul disini', style:
                    CustomFont.fontTitleCard(CustomColor.black, CustomSize.f19),),
                );
              }
            }
            return Center(
              child: Container(
                color: Colors.transparent,
                child: const CircularProgressIndicator(),
                height: 50, width: 50,
              ),
            );
          }),
        ),
      )
    );
  }
}
