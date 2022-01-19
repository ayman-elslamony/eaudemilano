//class AllOrders {
//  int  currentPage;
//  List<Data>  data;
//  int  total;
//
//  AllOrders({this.currentPage, this.data, this.total});
//
//  AllOrders.fromJson(Map<String, dynamic> json) {
//    currentPage = json['current_page'];
//    if (json['data'] != null) {
//      data = <Data>[];
//      json['data'].forEach((v) {
//        data.add(new Data.fromJson(v));
//      });
//    }
//    total = json['total'];
//  }
//
//}

class AllOrders {
  int  id;
  String  operationDate;
  String  serialNumber;
  String  countItems;
  String  total;

  AllOrders(
      {this.id,
        this.operationDate,
        this.serialNumber,
        this.countItems,
        this.total});

  AllOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    operationDate = json['operation_date'];
    serialNumber = json['serial_number'];
    countItems = json['count_items'];
    total = json['total'];
  }
  
}
