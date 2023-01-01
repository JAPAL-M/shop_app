class CategoriesModel{
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData{
  int? current_page;
  List<DataCat> data = [];
  
  CategoriesData.fromJson(Map<String, dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataCat.fromJson(element));
    });
  }
}

class  DataCat{
  int? id;
  String? name;
  String? image;

  DataCat.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}