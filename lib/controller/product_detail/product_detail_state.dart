part of 'product_detail_cubit.dart';

@immutable
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ModelProductDetail modelProductDetail;
  final int statusCart;

  ProductDetailLoaded._({
    required this.modelProductDetail,
    this.statusCart = 0});

  ProductDetailLoaded.getDetail({
    required ModelProductDetail modelProductDetail,
    required int statusCart}) :
        this._(
          modelProductDetail: modelProductDetail,
          statusCart: statusCart);
}

class ProductDetailError extends ProductDetailState{
  final String message;
  ProductDetailError({required this.message});
}
