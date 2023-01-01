import 'package:shop_app/models/Login.dart';

abstract class ShopStates{}

class ShopIntialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopIsLoadingState extends ShopStates{}
class ShopIsSuccessState extends ShopStates{}
class ShopIsErrorState extends ShopStates{}

class CategoriesIsLoadingState extends ShopStates{}
class CategoriesIsSuccessState extends ShopStates{}
class CategoriesIsErrorState extends ShopStates{}

class ProfileIsLoadingState extends ShopStates{}
class ProfileIsSuccessState extends ShopStates{
  final LoginClass userdata;

  ProfileIsSuccessState(this.userdata);
}
class ProfileIsErrorState extends ShopStates{}

class UpdateIsLoadingState extends ShopStates{}
class UpdateIsSuccessState extends ShopStates{
  final LoginClass update;

  UpdateIsSuccessState(this.update);
}
class UpdateIsErrorState extends ShopStates{}

class AddFavoriteIsLoadingState extends ShopStates{}
class AddFavoriteIsSuccessState extends ShopStates{}
class AddFavoriteIsErrorState extends ShopStates{}

class GetFavoriteIsLoadingState extends ShopStates{}
class GetFavoriteIsSuccessState extends ShopStates{}
class GetFavoriteIsErrorState extends ShopStates{}