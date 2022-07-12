import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jubelio/common/constant.dart';
import 'package:jubelio/common/custom_currency.dart';
import 'package:jubelio/common/custom_font.dart';
import 'package:jubelio/common/custom_snackbar.dart';
import 'package:jubelio/common/routes.dart';
import 'package:jubelio/controller/list_offline/list_offline_cubit.dart';
import 'package:jubelio/controller/product_detail/product_detail_cubit.dart';
import 'package:jubelio/controller/product_list/product_list_cubit.dart';
import 'package:jubelio/controller/search/search_cubit.dart';
import 'package:jubelio/view/widget/custom_loading.dart';
import 'package:jubelio/view/widget/custom_margin.dart';
import 'package:jubelio/view/widget/custom_responsive.dart';
import 'package:jubelio/view/widget/list_page_ui/widget_listpage_appbar.dart';
import 'package:jubelio/view/widget/list_page_ui/widget_listpage_body.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import '../../common/custom_color.dart';
import '../../common/custom_size.dart';
import '../../model/model_product_list.dart';
import '../widget/check_stock.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      online: Scaffold(
        appBar: widgetListPageAppBar(context, CustomColor.blueColor, Constant.widgetTitleOnline,
            () => Navigator.pushNamed(context, RoutesPage.searchPage),),
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
                      return widgetListPageBody(context, mpl,
                              () => Navigator.pushNamed(context, RoutesPage.detailPage,
                          arguments: {'prdNo': mpl.prdNo})
                      );
                    }
                ),
              );
            }
            return customLoading();
          }),
        ),
      ),
      offline: Scaffold(
        appBar: widgetListPageAppBar(context, CustomColor.grey, Constant.widgetTitleOffline,
              () => displaySnackbar(context, Constant.widgetSearchOffline),),
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
                      return widgetListPageBody(context, mpl,
                              () => displaySnackbar(context, Constant.widgetToDetail)
                      );
                    }
                ),
              );
            }
            return customLoading();
          }),
        )
      ),
    );
  }
}
