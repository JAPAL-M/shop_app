import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Screens/Login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/Shop/cubit.dart';
import 'package:shop_app/shared/cubit/Shop/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is UpdateIsSuccessState){
          if(state.update.status == true){
            nameController.text = state.update.data!.name.toString();
            emailController.text = state.update.data!.email.toString();
            phoneController.text = state.update.data!.phone.toString();
            showToast(text: state.update.message.toString(), color: Colors.green);
          }else{
            showToast(text: state.update.message.toString(), color: Colors.red);
          }
        }
      },
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.UserData!.data!.name.toString();
        emailController.text = cubit.UserData!.data!.email.toString();
        phoneController.text = cubit.UserData!.data!.phone.toString();
        return ConditionalBuilder(
            condition: cubit.UserData != null,
            builder: (context) => Scaffold(
              body: Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      if(state is UpdateIsLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      defaultTextFormField(
                          controller: nameController,
                          label: 'Name',
                          type: TextInputType.name,
                          perfixicon: Icons.person,
                          validator: (String? value){
                            if(value!.isEmpty)
                              return 'Name Is Empty';
                          }
                      ),
                      SizedBox(height: 20,),
                      defaultTextFormField(
                          controller: emailController,
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          perfixicon: Icons.email_outlined,
                          validator: (String? value){
                            if(value!.isEmpty)
                              return 'Email Is Empty';
                          }
                      ),
                      SizedBox(height: 20,),
                      defaultTextFormField(
                          controller: phoneController,
                          label: 'Phone',
                          type: TextInputType.phone,
                          perfixicon: Icons.phone,
                          validator: (String? value){
                            if(value!.isEmpty)
                              return 'Phone Is Empty';
                          }
                      ),
                      SizedBox(height: 30,),
                      defaultButton(onPressed: (){
                        if(formkey.currentState!.validate()) {
                          cubit.UpdateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        } }, text: 'UPDATE'),
                      SizedBox(height: 20,),
                      defaultButton(onPressed: (){
                        CacheHelper.removeData(key: 'token').then((value){
                          navigateAndFinish(context, LoginScreen());
                        });
                      }, text: 'LOGOUT')
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
