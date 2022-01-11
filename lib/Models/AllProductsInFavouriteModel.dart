class AllProductsInFavourite {
  int  currentPage;
  List<SpecificProductInFav>  products;
  int  totalProducts;

  AllProductsInFavourite({this.currentPage, this.products, this.totalProducts});

  AllProductsInFavourite.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    products = <SpecificProductInFav>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        products.add(SpecificProductInFav.fromJson(v));
      });
    }
    totalProducts = json['totalProducts'];
  }
}

class SpecificProductInFav {
  int  id;
  String  itemId;
  ProductDetails  productDetails;

  SpecificProductInFav({this.id, this.itemId, this.productDetails});

  SpecificProductInFav.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    productDetails =
    json['product'] != null ? ProductDetails.fromJson(json['product']) : null;
  }

}

class ProductDetails {
  int  id;
  bool enableLoader;
  String  title;
  String  priceBeforeDiscount;
  String  price;
  String  sizeId;
  String  image;
  String  sizeName;

  ProductDetails(
      {this.id,
        this.title,
        this.priceBeforeDiscount,
        this.price,
        this.sizeId,
        this.image,
        this.enableLoader = false,
        this.sizeName});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    sizeId = json['size_id'];
    image = json['image'];
    sizeName = json['size_name'];
    enableLoader = false;
  }
  
}
