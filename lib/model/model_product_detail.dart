class ModelProductDetail {
  final String? prdNm;
  final String? prdNo;
  final String? htmlDetail;
  final String? selPrc;
  final String? prdImage01;

  ModelProductDetail({
    required this.prdNm,
    required this.prdNo,
    required this.htmlDetail,
    required this.selPrc,
    required this.prdImage01});

  factory ModelProductDetail.fromJson(Map<String, dynamic> json){
    return ModelProductDetail(
        prdNm: json['prdNm'],
        prdNo: json['prdNo'],
        htmlDetail: json['htmlDetail'],
        selPrc: json['selPrc'],
        prdImage01: json['prdImage01'] ?? "",
    );
  }

  Map<String, dynamic> toJson(){
    var data = <String, dynamic>{};
    data['prdNm'] = prdNm;
    data['prdNo'] = prdNo;
    data['htmlDetail'] = htmlDetail;
    data['selPrc'] = selPrc;
    return data;
  }

}