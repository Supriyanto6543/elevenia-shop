import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jubelio/common/custom_font.dart';
import 'package:jubelio/common/custom_snackbar.dart';
import 'package:jubelio/common/routes.dart';
import 'package:jubelio/controller/list_offline/list_offline_cubit.dart';
import 'package:jubelio/controller/product_detail/product_detail_cubit.dart';
import 'package:jubelio/controller/product_list/product_list_cubit.dart';
import 'package:jubelio/view/widget/custom_responsive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import '../../common/custom_color.dart';
import '../../common/custom_size.dart';
import '../../model/model_product_list.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      online: Scaffold(
        appBar: AppBar(
          toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
          title: Text('BELAJAR XML - Mode Online', style:
            CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
          actions: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: (){
                      //Navigator.pushNamed(context, RoutesPage.searchPage, arguments: true);
                      showSearch(context: context, delegate: CustomDelegate(context: context));
                    },
                    child: Icon(Icons.search, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30,),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    key: const Key("toCart"),
                    onTap: (){
                      Navigator.pushNamed(context, RoutesPage.cartPage);
                    },
                    child: Icon(Icons.add_shopping_cart_rounded, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30,),
                  ),
                ),
              ],
            )
          ],
        ),
        body: BlocProvider(create: (_)=>ProductListCubit()..getProductList(),
          child: BlocBuilder<ProductListCubit, ProductListState>(builder: (context, state){
            if(state is ProductListLoaded){
              return SmartRefresher(
                controller: ProductListCubit.refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: context.read<ProductListCubit>().onRefresh,
                onLoading: state.list.length > 5 ? context.read<ProductListCubit>().onLoadMore : null,
                child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, i){
                      ModelProductList mpl = state.list[i];
                      return GestureDetector(
                        key: const Key("toDetailPage"),
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
                                Text('Qty: ${mpl.prdSelQty}', style:
                                CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                                const SizedBox(height: 4,),
                                checkStock(mpl, context),
                              ],
                            )
                        ),
                      );
                    }
                ),
              );
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
          title: Text('BELAJAR XML - Offline Mode', style:
            CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
          backgroundColor: CustomColor.grey,
          actions: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: (){
                      displaySnackbar(context, "Hidupkan Internet untuk mencari produk");
                    },
                    child: Icon(Icons.search, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesPage.cartPage);
                    },
                    child: Icon(Icons.add_shopping_cart_rounded, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30),
                  ),
                ),
              ],
            )
          ],
        ),
        body: BlocProvider(create: (_)=> ListOfflineCubit()..offlineData(),
          child: BlocBuilder<ListOfflineCubit, ListOfflineState>(builder: (context, state){
            if(state is ListOfflineLoaded){
              return SmartRefresher(
                controller: ListOfflineCubit.refreshController,
                enablePullDown: true,
                //enablePullUp: true,
                onRefresh: context.read<ListOfflineCubit>().onRefresh,
                //onLoading: context.read<ProductListCubit>().onLoadMore,
                child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, i){
                      ModelProductList mpl = state.list[i];
                      return GestureDetector(
                        onTap: (){
                          displaySnackbar(context, "Hidupkan Internet terlebih dahulu");
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
                                Text('Qty: ${mpl.prdSelQty}', style:
                                CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f17 : CustomSize.f24),),
                                const SizedBox(height: 4,),
                                checkStock(mpl, context),
                              ],
                            )
                        ),
                      );
                    }
                ),
              );
            }
            return Center(
              child: Container(
                color: Colors.transparent,
                child: const CircularProgressIndicator(),
                height: 50, width: 50,
              ),
            );
          }),
        )
      ),
    );
  }
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
}

class CustomDelegate extends SearchDelegate<String>{

  BuildContext context;

  CustomDelegate({required this.context});

  @override
  String? get searchFieldLabel => "Cari Produk";

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      hintColor: CustomColor.white,
      textTheme: TextTheme(displayMedium: CustomFont.fontTitleCard(CustomColor.white, CustomSize.f27)),
      appBarTheme: theme.appBarTheme.copyWith(toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(icon: Icon(Icons.chevron_left, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30),
      onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider<ProductListCubit>(create: (_) => ProductListCubit()..getSearchProduct(),
      child: BlocBuilder<ProductListCubit, ProductListState>(builder: (context, state){
        if(state is ProductListLoaded){
          return SmartRefresher(
            controller: ProductListCubit.refreshController2,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: context.read<ProductListCubit>().onRefreshSearch,
            onLoading: state.list.length > 5 ? context.read<ProductListCubit>().onLoadSearch : null,
            child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, i){
                  ModelProductList mpl = state.list[i];
                  if(mpl.prdNm!.toLowerCase().contains(query.toLowerCase())){
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
                              CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                              const SizedBox(height: 4,),
                              Text('Qty: ${mpl.prdSelQty}', style:
                              CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
                            ],
                          )
                      ),
                    );
                  }else{
                    return Container();
                  }
                }
            ),
          );
        }
        return Center(
          child: Container(
            color: Colors.transparent,
            child: const CircularProgressIndicator(),
            height: 50, width: 50,
          ),
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
