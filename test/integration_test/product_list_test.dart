import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jubelio/controller/product_list/product_list_cubit.dart';

void main(){

  const loaded = TypeMatcher<ProductListLoaded>();

  group("Fetch Product List from Elevania", (){

    /**
     * For test Fetch Product List must comment dbHelper on file product_list_cubit.dart
     * On line 33 until 37, because Sqflite can't mock using mocktail when both test ran
     */

    blocTest(
        "Fetch Product List",
        build: () => ProductListCubit(),
        act: (ProductListCubit cubit) => cubit.getProductList(),
        expect: () => [loaded]
    );

  });
}