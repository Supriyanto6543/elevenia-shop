part of 'product_list_cubit.dart';

@immutable
abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ModelProductList> list;
  final int index;
  ProductListLoaded._({required this.list, this.index = 1});

  ProductListLoaded.pList({required List<ModelProductList> list}) :
        this._(list: list);

  ProductListLoaded.pListOffline({
    required List<ModelProductList> list,
    required int index}) :
        this._(list: list, index: index);
}

class ProductListError extends ProductListState {
  final String message;
  ProductListError({required this.message});
}
