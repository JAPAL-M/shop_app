class ProfileModel{
  bool? status;
  UserData? data;

  ProfileModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData{
  String? name;
  String? email;
  String? phone;
  String? token;

  UserData.fromJson(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }
}