import 'package:bloc/bloc.dart';
import 'package:jubelio/common/db_helper.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/model_product_detail.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static final database = DbHelper();
  static final refresher = RefreshController();

  void getOfflineCart()async{
    final db = await database.getAllProductCart();
    List<ModelProductDetail> list = db.map((e) => ModelProductDetail(
        prdNm: e['prdnm'],
        prdNo: e['prdno'].toString(),
        htmlDetail: e['htmldetail'],
        selPrc: e['selprc'])).toList();
    emit(CartLoaded(list: list));
    refresher.refreshCompleted();
  }

  onRefresh(){
    getOfflineCart();
  }
}
