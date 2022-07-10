import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jubelio/common/custom_snackbar.dart';
import 'package:jubelio/common/db_helper.dart';
import 'package:jubelio/model/model_product_detail.dart';
import 'package:meta/meta.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import '../../common/constant.dart';
part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());

  static final database = DbHelper();
  static final scaffold = GlobalKey<ScaffoldState>();

  getProductDetail(String prdNo) async{
    try{
      var xml2json = Xml2Json();
      var request = await http.get(Uri.parse(Constant.baseUrl+Constant.detailProduct+prdNo),
          headers: {'openapikey': Constant.openApi, "Content-type": Constant.contentType});
      xml2json.parse(request.body);
      var convert = xml2json.toParker();
      var data = json.decode(convert)['Product'];
      ModelProductDetail mpd = ModelProductDetail.fromJson(data);
      emit(ProductDetailLoaded.getDetail(modelProductDetail: mpd, statusCart: 0));
    }catch(e){
      emit(ProductDetailError(message: "Internal server error"));
    }
  }

  getProductDetailOffline(String prdNo)async{
    try{
      var data = await database.getOfflineProductById(prdNo);
      ModelProductDetail detail = ModelProductDetail(
          prdNm: data[0]['prdnm'],
          prdNo: data[0]['prdno'].toString(),
          htmlDetail: data[0]['htmldetail'],
          selPrc: data[0]['selprc'],
          prdImage01: data[0]['prdimage']);
      emit(ProductDetailLoaded.getDetail(modelProductDetail: detail, statusCart: 0));
    }catch(e){
      emit(ProductDetailError(message: "Internal server error"));
    }
  }

  addToCart(ModelProductDetail list)async{
    var myState = state as ProductDetailLoaded;
    int i = await database.tableIsEmpty(list);
    if(i == 1){
      await database.deleteCart(list);
      emit(ProductDetailLoaded.getDetail(
          modelProductDetail: myState.modelProductDetail,
          statusCart: 0));
      displaySnackbar(scaffold.currentContext!, "Produk berhasil dihapus");
    }else{
      await database.insertDataCart(list);
      emit(ProductDetailLoaded.getDetail(
          modelProductDetail: myState.modelProductDetail,
          statusCart: 1));
      displaySnackbar(scaffold.currentContext!, "Produk berhasil ditambahkan");
    }
  }
}
