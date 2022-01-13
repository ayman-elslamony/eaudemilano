
class PopularCategories {
  int  id;
  String  title;
  String  popularity;
  Product  product;

  PopularCategories({this.id, this.title, this.popularity, this.product});

  PopularCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    popularity = json['popularity'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  int  id;
  String  title;
  String  priceBeforeDiscount;
  String  price;
  String  image;
  String  size;

  Product(
      {this.id,
        this.title,
        this.priceBeforeDiscount,
        this.price,
        this.image,
        this.size});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    image = json['image'];
    size = json['size'];
  }

}



