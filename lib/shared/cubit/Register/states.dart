import 'package:shop_app/models/Login.dart';

abstract class RegisterStates{}

class RegisterIntialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final LoginClass loginClass;

  RegisterSuccessState(this.loginClass);
}

class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}

class ChangeIconPassRe extends RegisterStates {}