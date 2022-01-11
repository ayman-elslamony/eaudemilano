class CategorieDetails {
  int id;
  String title;
  String priceBeforeDiscount;
  String price;
  String image;
  String sizeId;
  String sizeName;

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
