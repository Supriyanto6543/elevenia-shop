part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<ModelProductDetail> list;

  CartLoaded({required this.list});
}
