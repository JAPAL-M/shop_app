import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Search.dart';
import 'package:shop_app/models/Shop.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/Search/states.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(SearchIntialState());
  static SearchCubit get(context) => BlocProvider.of(context);


  SearchData? search;

  void SearchDataget({
  @required String? text
}){
    emit(SearchIsLoading());

    DioHelper.postData(
      token: token,
        url: Search, data: {
      'text': text
    }).then((value){
      search = SearchData.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((error){
      print(error.toString());
      emit(SearchError());
    });
  }
}