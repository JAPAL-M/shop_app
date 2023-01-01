import 'package:flutter/cupertino.dart';

class SearchData{
  bool? status;
  ProductsData? data;

  SearchData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = ProductsData.fromJson(json['data']);
  }
}

class ProductsData{
  int? current_page;
  List<Data> data = [];

  ProductsData.fromJson(Map<String, dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}