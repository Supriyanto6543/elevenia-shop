import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jubelio/common/constant.dart';
import 'package:jubelio/common/db_helper.dart';
import 'package:jubelio/model/model_product_detail.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MockDbHelper extends Mock implements DbHelper{}

main()async{
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  ModelProductDetail list = ModelProductDetail(
      prdNm: "Baseus Cable 1 Meter Micro USB",
      prdNo: "2668",
      htmlDetail: "hello test",
      selPrc: "5000",
      prdImage01: "https://i.pinimg.com/originals/bd/4e/77/bd4e77fd33771abbb34709d6d035c493.jpg");

  Map<String, dynamic> expectResult = {
    Constant.idCart: 1,
    Constant.prdnoCart: 2668,
    Constant.prdImageCart: "https://i.pinimg.com/originals/bd/4e/77/bd4e77fd33771abbb34709d6d035c493.jpg",
    Constant.titleCart: "Baseus Cable 1 Meter Micro USB",
    Constant.htmlCart: "hello test",
    Constant.priceCart: "5000",
  };

  test('Create, Insert and Duplicate Checking Local Database', () async {
    final dbHelper = DbHelper();
    var s = dbHelper.createDatabase(list);
    expect(await s, [expectResult]);
  });
}