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

class  AllBestSelling{
  int  currentPage;
  List<BestSellingContent>  bestSellingContent;
  int  total;

  AllBestSelling({this.currentPage, this.bestSellingContent, this.total});

  AllBestSelling.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      bestSellingContent = <BestSellingContent>[];
      json['data'].forEach((v) {
        bestSellingContent.add(BestSellingContent.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class BestSellingContent {
  int  id;
  String  title;
  String  priceBeforeDiscount;
  String  price;
  String  image;
  String  sizeId;
  String  sizeName;

  BestSellingContent(
      {this.id,
        this.title,
        this.priceBeforeDiscount,
        this.price,
        this.image,
        this.sizeId,
        this.sizeName});

  BestSellingContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    image = json['image'];
    sizeId = json['size_id'];
    sizeName = json['size_name'];
  }

}
