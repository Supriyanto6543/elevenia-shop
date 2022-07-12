class ModelProductList{
  String? selMthdCd;
  String? prdNm;
  String? prdSelQty;
  String? saleEndDate;
  String? saleStartDate;
  String? selPrc;
  String? prdNo;

  ModelProductList({
    required this.selMthdCd,
    required this.prdNm,
    required this.prdSelQty,
    required this.saleEndDate,
    required this.saleStartDate,
    required this.selPrc,
    required this.prdNo});

  factory ModelProductList.fromJson(Map<String, dynamic> json){
    return ModelProductList(
        selMthdCd: json['selMthdCd'],
        prdNm: json['prdNm'],
        prdSelQty: json['prdSelQty'],
        saleEndDate: json['saleEndDate'],
        saleStartDate: json['saleStartDate'],
        selPrc: json['selPrc'],
        prdNo: json['prdNo']
    );
  }

  Map<String, dynamic> toJson(){
    var data = <String, dynamic>{};
    data['prdNo'] = prdNo;
    data['prdNm'] = prdNm;
    data['selPrc'] = selPrc;
    data['prdSelQty'] = prdSelQty;
    data['selMthdCd'] = selMthdCd;
    data['saleEndDate'] = saleEndDate;
    data['saleStartDate'] = saleEndDate;
    return data;
  }

  @override
  toString(){
    return ('$prdNm - $selPrc');
  }

}