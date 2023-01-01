import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Shop_layout.dart';
import 'package:shop_app/modules/Screens/Login_screen.dart';
import 'package:shop_app/modules/Screens/onBoarding_screen.dart';
import 'package:shop_app/shared/BlocObserver/Bloc_Observer.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/Search/cubit.dart';
import 'package:shop_app/shared/cubit/Shop/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';
import 'package:shop_app/shared/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');

  if(CacheHelper.getData(key: 'token') ==null){
    token = '';
  } else{
  token = CacheHelper.getData(key: 'token');
  }

  if(onBoarding != null){
    if(token != null) widget = ShopLayout();
    else widget = LoginScreen();
  }else{
    widget = onBoadingScreen();
  }


  runApp(ShopApp(
    startWidget: widget,
  ));
}

class ShopApp extends StatelessWidget {
  

  final Widget? startWidget;

  ShopApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()..getProduct()..getCategories()..getUserData()..getFavorite(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        darkTheme: themDark,
        theme: themLight,
        home: startWidget,
      ),
    );
  }
}
