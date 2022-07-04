part of 'list_offline_cubit.dart';

@immutable
abstract class ListOfflineState {}

class ListOfflineInitial extends ListOfflineState {}

class ListOfflineLoaded extends ListOfflineState {

  final List<ModelProductList> list;

  ListOfflineLoaded({required this.list});
}
