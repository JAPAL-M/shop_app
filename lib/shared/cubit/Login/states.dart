import 'package:shop_app/models/Login.dart';

abstract class LoginStates{}

class LoginIntialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final LoginClass loginClass;

  LoginSuccessState(this.loginClass);
}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

class ChangeIconPass extends LoginStates{}