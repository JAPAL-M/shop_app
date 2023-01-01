import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Categories.dart';
import 'package:shop_app/models/Login.dart';
import 'package:shop_app/models/Shop.dart';
import 'package:shop_app/modules/Screens/Home%20Page/Categories_Screen.dart';
import 'package:shop_app/modules/Screens/Home%20Page/Favorite_Screen.dart';
import 'package:shop_app/modules/Screens/Home%20Page/Product_Screen.dart';
import 'package:shop_app/modules/Screens/Home%20Page/Settings_Screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/Shop/states.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super (ShopIntialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
  void ChangeBottomNav(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  ShopClass? shop;

  Map<int?,bool?> favorites = {};

  void getProduct(){
    emit(ShopIsLoadingState());

    DioHelper.getData(url: HOME,token: token).then((value){
      shop = ShopClass.fromJson(value.data);
      shop!.data!.products.forEach((element){
        favorites.addAll({
          element.id : element.in_favorites
        }
        );
      });
      print(favorites.toString());
      emit(ShopIsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopIsErrorState());
    });
  }

  CategoriesModel? categories;

  void getCategories(){
    emit(CategoriesIsLoadingState());

    DioHelper.getData(url: Categories,token: token).then((value){
      categories = CategoriesModel.fromJson(value.data);
      emit(CategoriesIsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesIsErrorState());
    });
  }

  LoginClass? UserData;

  void getUserData(){
    emit(ProfileIsLoadingState());

    DioHelper.getData(url: Profile,token: token).then((value){
      UserData = LoginClass.fromJson(value.data);
      emit(ProfileIsSuccessState(UserData!));
    }).catchError((error){
      print(error.toString());
      emit(ProfileIsErrorState());
    });
  }

  LoginClass? UpdateData;

  void UpdateUserData({
  @required String? name,
  @required String? email,
  @required String? phone,
}){
    emit(UpdateIsLoadingState());

    DioHelper.putData(url: Update,token: token,data: {
      'name': name,
      'email': email,
      'phone': phone
    }).then((value){
      UpdateData = LoginClass.fromJson(value.data);
      getUserData();
      emit(UpdateIsSuccessState(UpdateData!));
    }).catchError((error){
      print(error.toString());
      emit(UpdateIsErrorState());
    });
  }
  
  void AddFavorite({
    @required int? id
  }){
    emit(AddFavoriteIsLoadingState());


    DioHelper.postData(token: token,url: Favorite , data: {
      'product_id' : id
    }).then((value){
      favorites[id] = !favorites[id]!;
      getFavorite();
       print('done');
       emit(AddFavoriteIsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AddFavoriteIsErrorState());
    });
  }

  ShopClass? favorite;

  void getFavorite(){
    emit(GetFavoriteIsLoadingState());

    DioHelper.getData(url: HOME,token: token).then((value){
      favorite = ShopClass.fromJson(value.data);
      getFavorite();
      
      emit(GetFavoriteIsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetFavoriteIsErrorState());
    });
  }
}