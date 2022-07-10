import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jubelio/common/enum_status.dart';
import 'package:jubelio/controller/search/search_cubit.dart';
import 'package:jubelio/view/widget/custom_loading.dart';
import 'package:jubelio/view/widget/custom_not_found.dart';
import 'package:jubelio/view/widget/search_ui/widget_search_appbar.dart';
import 'package:jubelio/view/widget/search_ui/widget_search_body.dart';
import 'package:jubelio/view/widget/search_ui/widget_search_sorting.dart';
import 'package:jubelio/view/widget/search_ui/widget_search_sorting_name.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/custom_color.dart';
import '../../common/custom_currency.dart';
import '../../common/custom_font.dart';
import '../../common/custom_size.dart';
import '../../common/routes.dart';
import '../../model/model_product_list.dart';
import '../widget/check_stock.dart';
import '../widget/custom_margin.dart';
import '../widget/custom_responsive.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgetSearchAppBar(context),
      body: BlocBuilder<SearchCubit, SearchState>(builder: (context, state){
        if(state is SearchLoaded){
          if(state.statusAction == EnumStatusAction.search){
            return customLoading();
          }else if(state.statusAction == EnumStatusAction.searched){
            return SmartRefresher(
              controller: SearchCubit.refreshController2,
              enablePullDown: false,
              enablePullUp: true,
              onRefresh: context.read<SearchCubit>().onRefreshSearch,
              onLoading: context.read<SearchCubit>().onLoadSearch,
              child: ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (context, i){
                    ModelProductList mpl = state.list[i];
                    num? priceFromApi = num.tryParse(mpl.selPrc!);
                    num? priceSet = num.tryParse(state.setPrice.toStringAsFixed(0));
                    if(SearchCubit.searchProduct.text != "" && mpl.prdNm!.toLowerCase().contains(SearchCubit.searchProduct.text.toLowerCase())){
                      return widgetSearchBody(context, mpl);
                    }else if(mpl.prdNm!.toLowerCase().contains(state.nameProduct) && priceFromApi! <= priceSet!){
                      return widgetSearchBody(context, mpl);
                    }else{
                      return SizedBox.shrink();
                    }
                  }
              ),
            );
          }else if(state.statusAction == EnumStatusAction.notFound){
            return Container(child: Text('ITEM TIDAK ADA di database'),);
          }else{
            return widgetSearchSorting(context, state);
          }
        }else{
          return SizedBox.shrink();
        }
        return const SizedBox.shrink();
      }, bloc: BlocProvider.of(context)..changeStatus(),)
    );
  }
}
