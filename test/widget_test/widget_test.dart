import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jubelio/controller/product_detail/product_detail_cubit.dart';
import 'package:jubelio/controller/product_list/product_list_cubit.dart';
import 'package:jubelio/view/detail_page/detail_page.dart';
import 'package:jubelio/view/list_page/list_page.dart';
import 'package:mocktail/mocktail.dart';

class MockProductDetailCubit extends Mock implements ProductDetailCubit{}
class MockProductListCubit extends Mock implements ProductListCubit{}

void main(){

  MockProductDetailCubit mockProduct = MockProductDetailCubit();

  setUpAll((){
    mockProduct = MockProductDetailCubit();
  });

  group("Test Initial Widget Cubit", (){
    testWidgets("Test Widget ListPage", (tester) async{
      whenListen(MockProductListCubit(), Stream.fromIterable(
          [
            ProductListInitial(),
            ProductListLoaded.pList(list: const [])
          ]
      ));
      await tester.pumpWidget(
          MaterialApp(
              title: '',
              home: BlocProvider<ProductListCubit>(
                create: (context) => ProductListCubit(),
                child: const ListPage(),
              )
          )
      );
      final toCart = find.byType(Scaffold, skipOffstage: false);
      await tester.tap(toCart);
      expect(toCart, findsOneWidget);
    });

    testWidgets("Test Widget DetailPage", (tester)async{
      await tester.pumpWidget(
          BlocProvider<ProductDetailCubit>(
            create: (context) => mockProduct.getProductDetail("25920735"),
            child: const MaterialApp(
              home: DetailPage(prdNo: "25920735"),
            ),
          ),
      );

      final button = find.byType(Center, skipOffstage: false);
      await tester.tap(button);
      expect(button, findsOneWidget);
    });

  });
}