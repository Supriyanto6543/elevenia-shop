class Constant{
  static const String baseUrl = "http://api.elevenia.co.id/rest/prodservices/product/";
  static const String listProduct = "listing?page=";
  static const String detailProduct = "details/";
  static const String openApi = "721407f393e84a28593374cc2b347a98";
  static const String contentType = "application/xml";

  /*
   * Field for database sqflite product list
   */
  static const String tblList = "tbl_list";

  static const String id = "id";
  static const String prdno = "prdno";
  static const String title = "title";
  static const String price = "price";
  static const String qty = "qty";
  static const String status = "status";
  static const String selEndDate = "selEndDate";
  static const String selStarDate = "selStarDate";

  /*
   * Field for database sqflite product detail (cart)
   */
  static const String tblCart = "tbl_cart";

  static const String idCart = "id";
  static const String titleCart = "prdnm";
  static const String prdnoCart = "prdno";
  static const String htmlCart = "htmldetail";
  static const String priceCart = "selprc";

}