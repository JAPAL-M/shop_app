import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/Register/states.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';

import '../../../models/Login.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super (RegisterIntialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  
  LoginClass? register;

  void RegisterUser({
  @required String? email,
  @required String? pass,
  @required String? name,
  @required String? phone,
}){
    emit(RegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'email':email,
      'password':pass,
      'phone':phone,
      'name':name,
    }).then((value){
      print(value.data);


      register = LoginClass.fromJson(value.data);

      emit(RegisterSuccessState(register!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changeVisibility (){
    isPassword = !isPassword;
    suffix =  isPassword ? Icons.visibility_off_outlined : Icons.visibility_sharp;
    emit(ChangeIconPassRe());
  }

}