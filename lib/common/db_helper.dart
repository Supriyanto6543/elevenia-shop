import 'package:jubelio/common/constant.dart';
import 'package:jubelio/model/model_product_detail.dart';
import 'package:jubelio/model/model_product_list.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  static Database? _database;
  static Database? _databaseCart;

  Future<Database?> get databaseCart async{
    _databaseCart ??= await openCart();
    return _databaseCart;
  }

  Future<Database> openCart()async{
    var path = await getDatabasesPath();
    final dbPath = '$path/jubeliocart.db';
    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreateCart);
    return db;
  }

  Future _onCreateCart(Database db, int version)async{
    await db.execute(
        '''
        CREATE TABLE ${Constant.tblCart} (
        ${Constant.idCart} INTEGER PRIMARY KEY, 
        ${Constant.prdnoCart} INTEGER,
        ${Constant.titleCart} TEXT, 
        ${Constant.htmlCart} TEXT,
        ${Constant.priceCart} TEXT );
      '''
    );
  }

  Future<int> insertDataCart(ModelProductDetail list)async{
    final db = await databaseCart;
    Map<String, dynamic> columnInsert = {
      Constant.prdnoCart: list.prdNo,
      Constant.titleCart: list.prdNm,
      Constant.htmlCart: list.htmlDetail,
      Constant.priceCart: list.selPrc,
    };
    return db!.insert(Constant.tblCart, columnInsert);
  }

  Future<int> deleteCart(ModelProductDetail list)async{
    final db = await databaseCart;
    return await db!.delete(
      Constant.tblCart, where: '${Constant.prdnoCart} = ?', whereArgs: [list.prdNo]
    );
  }

  tableIsEmpty(ModelProductDetail list)async{
    var db = await databaseCart;
    int? count = Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM ${Constant.tblCart} WHERE prdno = ${list.prdNo}'));
    return count;
  }

  Future<List<Map<String, dynamic>>> getAllProductCart()async{
    final db = await databaseCart;
    final List<Map<String, dynamic>> result = await db!.query(Constant.tblCart);
    return result;
  }

  Future<Database?> get database async{
    _database ??= await open();
    return _database;
  }

  Future<Database> open()async{
    var path = await getDatabasesPath();
    final dbPath = '$path/jubelio.db';
    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version)async{
    await db.execute(
      '''
        CREATE TABLE ${Constant.tblList} (
        ${Constant.id} INTEGER PRIMARY KEY, 
        ${Constant.prdno} INTEGER,
        ${Constant.title} TEXT, 
        ${Constant.price} TEXT,
        ${Constant.qty} TEXT,
        ${Constant.status} TEXT,
        ${Constant.selEndDate} TEXT,
        ${Constant.selStarDate} TEXT );
      '''
    );
  }

  Future<int> insertData(ModelProductList list)async{
    final db = await database;
    Map<String, dynamic> columnInsert = {
      Constant.prdno: list.prdNo,
      Constant.title: list.prdNm,
      Constant.price: list.selPrc,
      Constant.qty: list.prdSelQty,
      Constant.status: list.selMthdCd,
      Constant.selEndDate: list.saleEndDate,
      Constant.selStarDate: list.saleStartDate
    };
    return db!.insert(Constant.tblList, columnInsert);
  }

  Future deleteAll()async{
    final db = await database;
    return db!.delete(Constant.tblList);
  }

  Future<List<Map<String, dynamic>>> getAllProduct()async{
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(Constant.tblList);
    return result;
  }

}