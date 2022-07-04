import 'package:bloc/bloc.dart';
import 'package:jubelio/common/db_helper.dart';
import 'package:jubelio/model/model_product_detail.dart';
import 'package:jubelio/model/model_product_list.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'list_offline_state.dart';

class ListOfflineCubit extends Cubit<ListOfflineState> {
  ListOfflineCubit() : super(ListOfflineInitial());

  static final refreshController = RefreshController();
  static final database = DbHelper();

  void offlineData()async{
    final db = await database.getAllProduct();
    List<ModelProductList> list = db.map((e) => ModelProductList(
        selMthdCd: e['status'],
        prdNm: e['title'],
        prdSelQty: e['qty'],
        saleEndDate: e['saleEndDate'],
        saleStartDate: e['selStarDate'],
        selPrc: e['price'],
        prdNo: e['prdno'].toString())).toList();
    emit(ListOfflineLoaded(list: list));
    refreshController.refreshCompleted();
  }

  void onRefresh(){
    offlineData();
  }
}
