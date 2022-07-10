class Constant{
  static const String baseUrl = "http://api.elevenia.co.id/rest/prodservices/product/";
  static const String listProduct = "listing?page=";
  static const String detailProduct = "details/";
  static const String openApi = "721407f393e84a28593374cc2b347a98";
  static const String contentType = "application/xml";

  /*
   * Field for widget
   */
  static const String widgetProductName = "Nama Product:";
  static const String widgetHarga = "Harga:";
  static const String widgetNoId = "No Id:";
  static const String widgetQty = "Qty:";
  static const String widgetSearchOffline = "Hidupkan Internet untuk Mencari Produk";
  static const String widgetToDetail = "Hidupkan Internet terlebih dahulu";
  static const String widgetTitleOnline = "Elevenia Shop - Online Mode";
  static const String widgetTitleOffline = "Elevenia Shop - Offline Mode";
  static const String widgetCartNoItem = "Item mu akan muncul disini";
  static const String widgetCartTitleOffline = "Cart Page - Offline Mode";
  static const String widgetCartTitleOnline = "Cart Page - Online Mode";
  static const String widgetHintSearch = "Search...";

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
  static const String prdImageCart = "prdimage";
  static const String htmlCart = "htmldetail";
  static const String priceCart = "selprc";

}