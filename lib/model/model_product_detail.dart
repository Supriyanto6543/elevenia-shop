class ModelProductDetail {
  final String? prdNm;
  final String? prdNo;
  final String? htmlDetail;
  final String? selPrc;

  ModelProductDetail({
    required this.prdNm,
    required this.prdNo,
    required this.htmlDetail,
    required this.selPrc});

  factory ModelProductDetail.fromJson(Map<String, dynamic> json){
    return ModelProductDetail(
        prdNm: json['prdNm'],
        prdNo: json['prdNo'],
        htmlDetail: json['htmlDetail'],
        selPrc: json['selPrc']
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