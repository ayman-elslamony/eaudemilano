class AllProductsInCart {
  int currentPage;
  List<SpecificProductInCart> specificProduct;
  int totalProducts;

  AllProductsInCart({this.currentPage, this.specificProduct, this.totalProducts});

  AllProductsInCart.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalProducts = json['total'];
    if (json['data'] != null) {
      specificProduct = <SpecificProductInCart>[];
      json['data'].forEach((v) {
        specificProduct
        .add(SpecificProductInCart.fromJson(v));
      });
    }

  }

}

class SpecificProductInCart {
  int id;
  String favorite;
  String price;
  String quantity;
  String total;
  String itemId;
  String sizeId;
  String sizeName;
  ProductDetails product;

  SpecificProductInCart({this.id,
    this.favorite,
    this.price,
    this.quantity,
    this.total,
    this.itemId,
    this.sizeId,
    this.sizeName,
    this.product});

  SpecificProductInCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favorite = json['favorite'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    itemId = json['item_id'];
    sizeId = json['size_id'];
    sizeName = json['size_name'];
    product =
        json['product'] != null ? ProductDetails.fromJson(json['product'])
    :
    null;
  }


}

class ProductDetails {
  int id;
  String title;
  String image;
  ProductDetails({this.id, this.title, this.image});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }


}
