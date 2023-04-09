class FavoritesModel {
  bool status;
  FavoritesDataModel data;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data =
        json['data'] != null ? FavoritesDataModel.fromJson(json['data']) : null;
  }
}

class FavoritesDataModel {
  int currentPage;
  List<FavoriteElementModel> data = [];
  int total;

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    this.currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(FavoriteElementModel.fromJson(element));
    });
    this.total = json['total'];
  }
}

class FavoriteElementModel {
  int id;
  FavoriteProductModel model;
  FavoriteElementModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.model = FavoriteProductModel.fromJson(json['product']);
  }
}

class FavoriteProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.price = json['price'];
    this.oldPrice = json['old_price'];
    this.discount = json['discount'];
    this.image = json['image'];
    this.name = json['name'];
  }
}
