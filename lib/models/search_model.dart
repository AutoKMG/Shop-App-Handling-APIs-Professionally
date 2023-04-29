class SearchModel {
  bool status;
  SearchModelData data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data =
        json['data'] != null ? SearchModelData.fromJson(json['data']) : null;
  }
}

class SearchModelData {
  int currentPage;
  SearchModelProductData productData;
  int total;
  SearchModelData.fromJson(Map<String, dynamic> json) {
    this.currentPage = json['current_page'];
    this.productData = json['data'] != null
        ? SearchModelProductData.fromJson(json['data'])
        : null;
    this.total = json['total'];
  }
}

class SearchModelProductData {
  int id;
  String price;
  String image;
  String name;
  String description;
  List images;
  bool inFavorties;
  bool inCart;
  SearchModelProductData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.price = json['price'];
    this.image = json['image'];
    this.name = json['name'];
    this.description = json['description'];
    this.images = json['images'];
    this.inFavorties = json['in_favorites'];
    this.inCart = json['in_cart'];
  }
}
