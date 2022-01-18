class MyOrder {
  int   id;
  List<ProductDetail>   details;
  int   total;

  MyOrder({this.id, this.details, this.total});

  MyOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['details'] != null) {
      details = <ProductDetail>[];
      json['details'].forEach((v) {
        details.add( ProductDetail.fromJson(v));
      });
    }
    total = json['total'];
  }
  
}

class ProductDetail {
  int   id;
  String   title;
  String   quantity;
  String   total;
  String   size;

  ProductDetail({this.id, this.title, this.quantity, this.total, this.size});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    total = json['total'];
    size = json['size'];
  }

}
