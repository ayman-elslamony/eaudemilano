
class ProductView {
  ProductDetails productDetails;
  List<ProductSizes> productDetailsSizes;
  List<ProductImages> productDetailsImages;
  List<SimilarProducts> similarProducts;

  ProductView({this.productDetails,
    this.productDetailsSizes,
    this.productDetailsImages,
    this.similarProducts});

  ProductView.fromJson(Map<String, dynamic> json) {
    productDetails =
        json['product'] != null ? ProductDetails.fromJson(json['product'])
    : null;
    if (json['product_sizes'] != null) {
    productDetailsSizes = <ProductSizes>[];
    json['product_sizes'].forEach((v) {
    productDetailsSizes.add( ProductSizes.fromJson(v));
    });
    }
    if (json['product_images'] != null) {
    productDetailsImages = <ProductImages>[];
    json['product_images'].forEach((v) {
    productDetailsImages.add( ProductImages.fromJson(v));
    });
    }
    if (json['similar_products'] != null) {
    similarProducts = <SimilarProducts>[];
    json['similar_products'].forEach((v) {
    similarProducts.add( SimilarProducts.fromJson(v));
    });
    }else{
      similarProducts = [];
    }
  }

}

class ProductDetails {
  int id;
  String title;
  String category;
  String priceBeforeDiscount;
  String price;
  String size;
  String description;
  String image;
  String favorite;
  ProductInCart productInCart =
  ProductInCart(
      quantity: '0',
      sizeId: '',
      sizeName: ''
  );

  ProductDetails({this.id,
    this.title,
    this.category,
    this.priceBeforeDiscount,
    this.price,
    this.size,
    this.description,
    this.productInCart,
    this.image,this.favorite});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    size = json['size'];
    description = json['description'];
    image = json['image'];
    favorite=json['favorite'];
    if (json['product_in_cart'] != null) {
      json['product_in_cart'].forEach((v) {
        productInCart=ProductInCart.fromJson(v);
      });
    }
  }

}
class ProductInCart {
  int id;
  String sizeId='';
  String sizeName;
  String quantity='0';

  ProductInCart({this.id, this.sizeId='', this.sizeName='6644', this.quantity='0'});

  ProductInCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeId = json['size_id']??'';
    sizeName = json['size_name']??'';
    quantity = json['quantity']??'0';
  }

}
class ProductSizes {
  int id;
  String sizeId;
  String sizeName;
  String priceBeforeDiscount;
  String price;
  bool isSelected;

  ProductSizes({this.id,
    this.sizeId,
    this.sizeName,
    this.priceBeforeDiscount,
    this.isSelected=false,
    this.price});

  ProductSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeId = json['size_id'];
    sizeName = json['size_name'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    isSelected=false;
  }

}

class ProductImages {
  int id;
  String image;

  ProductImages({this.id, this.image});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

}

class SimilarProducts {
  int id;
  String title;
  String priceBeforeDiscount;
  String price;
  String image;
  String size;

  SimilarProducts({this.id,
    this.title,
    this.priceBeforeDiscount,
    this.price,
    this.image,
    this.size});

  SimilarProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    image = json['image'];
    size = json['size'];
  }


}
