//class  {
//  BestSellingContent  data;
//
//  AllBestSelling({this.data});
//
//  AllBestSelling.fromJson(Map<String, dynamic> json) {
//    data = json['data'] != null ? BestSellingContent.fromJson(json['data']) : null;
//  }
//
//}

class AllProducts {
  int currentPage;
  List<ProductsContent> bestSellingContent;
  int total;

  AllProducts({this.currentPage, this.bestSellingContent, this.total});

  AllProducts.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      bestSellingContent = <ProductsContent>[];
      json['data'].forEach((v) {
        bestSellingContent.add(ProductsContent.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class ProductsContent {
  int id;
  String title;
  String priceBeforeDiscount;
  String price;
  String image;
  String sizeId;
  String sizeName;

  ProductsContent(
      {this.id,
      this.title,
      this.priceBeforeDiscount,
      this.price,
      this.image,
      this.sizeId,
      this.sizeName});

  ProductsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    image = json['image'];
    sizeId = json['size_id'];
    sizeName = json['size_name'];
  }
}
