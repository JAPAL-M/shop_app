import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/Register/cubit.dart';
import 'package:shop_app/shared/cubit/Register/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var EmailController = TextEditingController();
  var PassController = TextEditingController();
  var NameController = TextEditingController();
  var PhoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            if(state.loginClass.status == true){
              showToast(text: state.loginClass.message.toString(), color: Colors.green);
              CacheHelper.saveData(key: 'token', value: state.loginClass.data!.token).then((value){
                token = CacheHelper.getData(key: 'token');
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              showToast(text: state.loginClass.message.toString(), color: Colors.red);
            }
          }
        },
        builder: (context,state){
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                            'register now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            controller: NameController,
                            label: 'Name',
                            type: TextInputType.name,
                            perfixicon: Icons.person,
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Name Is Empty';
                            }
                        ),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: PhoneController,
                            label: 'Phone',
                            type: TextInputType.phone,
                            perfixicon: Icons.phone,
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Phone Is Empty';
                            }
                        ),
                        SizedBox(height: 15,),
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
                            controller: PassController,
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            perfixicon: Icons.lock_outline,
                            obscureText: RegisterCubit.get(context).isPassword,
                            suffixicon: IconButton(
                              onPressed: (){
                                RegisterCubit.get(context).changeVisibility();
                              },
                              icon: Icon(RegisterCubit.get(context).suffix),
                            ),
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Password Is Empty';
                            }
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: (){
                           if(formkey.currentState!.validate()) {
                             RegisterCubit.get(context).RegisterUser(
                                 email: EmailController.text,
                                 pass: PassController.text,
                                 name: NameController.text,
                                 phone: PhoneController.text
                             );
                           }
                            },
                            text: 'SIGN UP',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text('Login Now')
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
