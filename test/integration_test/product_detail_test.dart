import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jubelio/controller/product_detail/product_detail_cubit.dart';

void main(){

  const loaded = TypeMatcher<ProductDetailLoaded>();
  const error = TypeMatcher<ProductDetailError>();

  group("Test Product Detail", (){

    blocTest(
        "Fetch Error Detail Product",
        build: () => ProductDetailCubit(),
        act: (ProductDetailCubit cubit) => cubit.getProductDetail("3"),
        expect: () => [error]
    );

    blocTest(
        "Fetch Succeed Detail Product",
        build: () => ProductDetailCubit(),
        act: (ProductDetailCubit cubit) => cubit.getProductDetail("25920735"),
        expect: () => [loaded]
    );

  });

}