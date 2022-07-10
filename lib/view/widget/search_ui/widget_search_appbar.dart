import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jubelio/common/constant.dart';

import '../../../common/custom_size.dart';
import '../../../controller/search/search_cubit.dart';
import '../custom_responsive.dart';

AppBar widgetSearchAppBar(BuildContext context){
  return AppBar(
    toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
    title: Container(
      width: double.infinity,
      height: 40,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          controller: SearchCubit.searchProduct,
          onSubmitted: (_){
            context.read<SearchCubit>().getSearchProduct(setPrice: 3000, nameProduct: "");
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  SearchCubit.searchProduct.clear();
                  context.read<SearchCubit>().changeStatus();
                },
              ),
              hintText: Constant.widgetHintSearch,
              border: InputBorder.none),
        ),
      ),
    ),
    leading: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back_ios),
    ),
  );
}