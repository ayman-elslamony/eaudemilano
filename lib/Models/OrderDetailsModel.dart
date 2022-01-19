//class OrderDeatils {
//  String  message;
//  List<Data>  data;
//
//  OrderDeatils({this.message, this.data});
//
//  OrderDeatils.fromJson(Map<String, dynamic> json) {
//    message = json['message'];
//    if (json['data'] != null) {
//      data = <Data>[];
//      json['data'].forEach((v) {
//        data!.add(new Data.fromJson(v));
//      });
//    }
//  }
//}

class OrderDetails {
  int  id;
  String  title;
  String  size;
  String  quantity;
  String  price;
  String  total;

  OrderDetails({this.id, this.title, this.size, this.quantity, this.price, this.total});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    size = json['size'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
  }
}
