

//class CategorieDetails {
//
//  List<Product>  products;
//
//  CategorieDetails({this.currentPage, this.products, this.totalPages});
//
//  CategorieDetails.fromJson(Map<String, dynamic> json) {
//    currentPage = json['current_page'];
//    if (json['data'] != null) {
//      products = <Product>[];
//      json['data'].forEach((v) {
//        products.add( Product.fromJson(v));
//      });
//    }
//    totalPages = json['total'];
//  }
//
//
//}

class CategorieDetails {
  int  id;
  String  title;
  String  priceBeforeDiscount;
  String  price;
  String  image;
  String  sizeId;
  String  sizeName;

  CategorieDetails(
      {this.id,
        this.title,
        this.priceBeforeDiscount,
        this.price,
        this.image,
        this.sizeId,
        this.sizeName});

  CategorieDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    image = json['image'];
    sizeId = json['size_id'];
    sizeName = json['size_name'];
  }


}
