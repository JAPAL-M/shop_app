import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Shop_layout.dart';
import 'package:shop_app/modules/Screens/Register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/Login/cubit.dart';
import 'package:shop_app/shared/cubit/Login/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {

  var EmailController = TextEditingController();
  var PassController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            if(state.loginClass.status == true){
              showToast(text: state.loginClass.message.toString() , color: Colors.green);
              CacheHelper.saveData(key: 'token', value: state.loginClass.data!.token.toString()).then((value){
                token = CacheHelper.getData(key: 'token');
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              showToast(text: state.loginClass.message.toString() , color: Colors.red);
            }
          }
        },
        builder: (context,state){
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                            'login now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            controller: EmailController,
                            label: 'Email Address',
                            type: TextInputType.emailAddress,
                            perfixicon: Icons.email_outlined,
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Email Address Is Empty';
                            }
                        ),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                            obscureText: cubit.isPassword,
                            controller: PassController,
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            perfixicon: Icons.lock_outline,
                            suffixicon: IconButton(
                                onPressed: (){
                                  cubit.changeVisibility();
                                },
                              icon: Icon(cubit.suffix),
                            ),
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Email Address Is Empty';
                            }
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: (){
                              if(formkey.currentState!.validate()){
                                cubit.loginUser(email: EmailController.text, pass: PassController.text);
                              }
                            },
                            text: 'LOGIN',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: (){
                                  navigateto(context, RegisterScreen());
                                },
                                child: Text('Register Now')
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
