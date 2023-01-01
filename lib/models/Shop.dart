class ShopClass{
  bool? status;
  ShopData? data;

  ShopClass.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = ShopData.fromJson(json['data']);
  }
}

class ShopData{
  List<BannersData> banners = [];
  List<ProductsData> products = [];

  ShopData.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannersData.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsData.fromJson(element));
    });
  }
}

class BannersData{
  int? id;
  String? image;

  BannersData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductsData{
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  ProductsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}