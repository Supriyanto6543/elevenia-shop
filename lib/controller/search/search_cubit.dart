import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jubelio/common/enum_status.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import '../../common/constant.dart';
import '../../common/db_helper.dart';
import '../../model/model_product_list.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchLoaded._(list: []));

  static final searchProduct = TextEditingController();
  static final refreshController2 = RefreshController();
  static DbHelper dbHelper = DbHelper();

  sortingProductName({required String name}){
    if(state is SearchLoaded){
      var my = state as SearchLoaded;
      emit(SearchLoaded.sortingProduct(
          list: [],
          maxPrice: my.maxPrice,
          setPrice: my.setPrice, name: name));
    }
  }

  updateSorting({required double maxPrice, required double setPrice}){
    if(state is SearchLoaded){
      var my = state as SearchLoaded;
      emit(SearchLoaded.sortingProduct(
          list: [],
          maxPrice: maxPrice,
          setPrice: setPrice, name: my.nameProduct));
    }
  }

  void getSearchProduct({required double setPrice, required String nameProduct})async{
    try{
      emit(SearchLoaded.enumStatus(statusAction: EnumStatusAction.search));
      var xml2json = Xml2Json();
      var request = await http.get(Uri.parse(Constant.baseUrl+Constant.listProduct+1.toString()),
          headers: {'openapikey': Constant.openApi, "Content-type": Constant.contentType});
      xml2json.parse(request.body);
      var convert = xml2json.toParker();
      List data = json.decode(convert)["Products"]["product"];
      List<ModelProductList> list = data.map((e) => ModelProductList.fromJson(e)).toList();
      emit(SearchLoaded.getSearch(
          list: list,
          statusAction: EnumStatusAction.searched,
          setPrice: setPrice,
          name: nameProduct));
    }catch(e){
      log("error load get product $e");
    }finally{
      refreshController2.refreshCompleted();
    }
  }

  void changeStatus(){
    emit(SearchLoaded.enumStatus(statusAction: EnumStatusAction.empty));
  }

  void changeStatusNotFound(){
    emit(SearchLoaded.enumStatus(statusAction: EnumStatusAction.notFound));
  }

  void onLoadSearch()async{
    var myIndex = state as SearchLoaded;
    int index = myIndex.index + 1;
    var xml2json = Xml2Json();
    var request = await http.get(Uri.parse(Constant.baseUrl+Constant.listProduct+index.toString()),
        headers: {'openapikey': Constant.openApi, "Content-type": Constant.contentType});

    xml2json.parse(request.body);
    var convert = xml2json.toParker();
    List data = json.decode(convert)["Products"]["product"];
    if(state is SearchLoaded){
      var myState = state as SearchLoaded;
      List<ModelProductList> list = data.map((e) => ModelProductList.fromJson(e)).toList();
      List<ModelProductList> newLoad = myState.list;
      list = [...newLoad, ...list];
      emit(SearchLoaded.getSearch(
          list: list,
          statusAction: EnumStatusAction.searched,
          setPrice: myIndex.setPrice,
          name: myIndex.nameProduct));
      refreshController2.loadComplete();
    }
  }

  void onRefreshSearch(){
    var myState = state as SearchLoaded;
    getSearchProduct(setPrice: myState.minPrice, nameProduct: myState.nameProduct);
  }
}
