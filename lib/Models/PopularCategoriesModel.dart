class AllPopularCategories {
  List<PopularCategories>  allPopularCategories;

  AllPopularCategories({this.allPopularCategories});

  AllPopularCategories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      allPopularCategories = <PopularCategories>[];
      json['data'].forEach((v) {
        allPopularCategories.add( PopularCategories.fromJson(v));
      });
    }
  }

}

class PopularCategories {
  int  id;
  String  title;
  String  popularity;
  List<Product>  products;

  PopularCategories({this.id, this.title, this.popularity, this.products});
  PopularCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    popularity = json['popularity'];
    if (json['product'] != null) {
      products = <Product>[];
      json['data'].forEach((v) {
        products.add( Product.fromJson(v));
      });
    }
  }
}

class Product{
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
