import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:jubelio/common/constant.dart';
import 'package:jubelio/common/db_helper.dart';
import 'package:jubelio/model/model_product_list.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xml2json/xml2json.dart';
part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());

  static final refreshController = RefreshController();
  static DbHelper dbHelper = DbHelper();

  getProductList()async{
    try{
      var xml2json = Xml2Json();
      var request = await http.get(Uri.parse(Constant.baseUrl+Constant.listProduct+1.toString()),
          headers: {'openapikey': Constant.openApi, "Content-type": Constant.contentType});
      xml2json.parse(request.body);
      var convert = xml2json.toParker();
      List data = json.decode(convert)["Products"]["product"];
      List<ModelProductList> list = data.map((e) => ModelProductList.fromJson(e)).toList();
      dbHelper.deleteAll();
      for (var element in data) {
        ModelProductList list = ModelProductList.fromJson(element);
        dbHelper.insertData(list);
      }
      emit(ProductListLoaded.pList(list: list));
    }catch(_){
      emit(ProductListError(message: "Internal server error"));
    }finally{
      refreshController.refreshCompleted();
    }
  }

  void onLoadMore()async{
    var myIndex = state as ProductListLoaded;
    int index = myIndex.index + 1;
    var xml2json = Xml2Json();
    var request = await http.get(Uri.parse(Constant.baseUrl+Constant.listProduct+index.toString()),
        headers: {'openapikey': Constant.openApi, "Content-type": Constant.contentType});
    xml2json.parse(request.body);
    var convert = xml2json.toParker();
    List data = json.decode(convert)["Products"]["product"];
    if(state is ProductListLoaded){
      var myState = state as ProductListLoaded;
      List<ModelProductList> list = data.map((e) => ModelProductList.fromJson(e)).toList();
      List<ModelProductList> newLoad = myState.list;
      list = [...newLoad, ...list];
      dbHelper.deleteAll();
      for (var element in list) {
        ModelProductList list = ModelProductList.fromJson(element.toJson());
        dbHelper.insertData(list);
      }
      emit(ProductListLoaded.pList(list: list));
      refreshController.loadComplete();
    }
  }

  void onRefresh(){
    getProductList();
  }
}
