class SearchModel {
  int id;
  String title;
  String priceBeforeDiscount;
  String price;
  String image;
  String size;

  SearchModel(
      {this.id,
      this.title,
      this.priceBeforeDiscount,
      this.price,
      this.image,
      this.size});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    image = json['image'];
    size = json['size'];
  }
}