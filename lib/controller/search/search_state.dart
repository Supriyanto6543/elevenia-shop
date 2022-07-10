part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ModelProductList> list;
  final int index;
  final EnumStatusAction statusAction;
  double maxPrice;
  double minPrice = 3000;
  double setPrice;
  String nameProduct;

  SearchLoaded._({
    required this.list,
    this.index = 1,
    this.statusAction = EnumStatusAction.empty,
    this.nameProduct = "",
    this.maxPrice = 500000,
    this.setPrice = 3000});

  SearchLoaded.enumStatus({
    required EnumStatusAction statusAction}) :
        this._(
          list: [],
          statusAction: statusAction
        );

  SearchLoaded.sortingProduct({
    required List<ModelProductList> list,
    required double maxPrice,
    required double setPrice,
    required String name}) :
        this._(
          list: list,
          maxPrice:
          maxPrice,
          setPrice: setPrice,
          nameProduct: name);

  SearchLoaded.getSearch({required List<ModelProductList> list,
    required EnumStatusAction statusAction,
    required double setPrice,
    required String name}) :
        this._(
          list: list,
          statusAction: statusAction,
          setPrice: setPrice,
          nameProduct: name);
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
