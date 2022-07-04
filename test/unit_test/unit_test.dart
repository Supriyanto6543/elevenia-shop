import 'package:flutter/cupertino.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jubelio/common/db_helper.dart';
import 'package:jubelio/controller/list_offline/list_offline_cubit.dart';
import 'package:jubelio/controller/product_list/product_list_cubit.dart';
import 'package:jubelio/model/model_product_detail.dart';
import 'package:mocktail/mocktail.dart';

class MockDbHelper extends Mock implements DbHelper{}

void main(){

  MockDbHelper dbHelper = MockDbHelper();
  ModelProductDetail modelProductDetail = ModelProductDetail(
      prdNm: "Baseus Cable 1 Meter Micro USB",
      prdNo: "2668",
      htmlDetail: "hello test",
      selPrc: "5000");

  ModelProductDetail modelCompare = ModelProductDetail(
      prdNm: "Baseus Cable 1 Meter Micro USB",
      prdNo: "266834",
      htmlDetail: "hello test",
      selPrc: "5000");

  test("Check for Table is Same or not Using Model", (){
    when(() => dbHelper.tableIsEmpty(modelProductDetail)).thenAnswer((_) => 1);
    final result = dbHelper.tableIsEmpty(modelProductDetail);
    expect(result, dbHelper.tableIsEmpty(modelProductDetail));
  });
}