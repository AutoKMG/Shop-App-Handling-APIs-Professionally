class HomeModel {
  bool status;
  HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int id;
  String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.image = json['image'];
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  List<dynamic> images;
  bool inFavorties;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.price = json['price'];
    this.oldPrice = json['old_price'];
    this.discount = json['discount'];
    this.image = json['image'];
    this.name = json['name'];
    this.images = json['images'];
    this.inFavorties = json['in_favorites'];
    this.inCart = json['in_cart'];
  }
}
