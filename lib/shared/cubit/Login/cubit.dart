import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/Login/states.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';

import '../../../models/Login.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super (LoginIntialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  
  LoginClass? login;

  void loginUser({
  @required String? email,
  @required String? pass,
}){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':pass,
    }).then((value){
      print(value.data);


      login = LoginClass.fromJson(value.data);

      emit(LoginSuccessState(login!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changeVisibility (){
    isPassword = !isPassword;
    suffix =  isPassword ? Icons.visibility_off_outlined : Icons.visibility_sharp;
    emit(ChangeIconPass());
  }

}