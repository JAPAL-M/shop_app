import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/style/colors.dart';

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
void navigateto(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget defaultTextFormField(
        {
         required var controller,
       required String? label,
       required var type,
       required IconData? perfixicon,
       IconButton? suffixicon,
       required var validator,
        bool obscureText = false,
          onFieldSubmitted
        }) => TextFormField(
      onChanged: onFieldSubmitted,
      obscureText: obscureText,
      validator: validator,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(perfixicon),
          suffixIcon: suffixicon,
          labelText: label,
          border: OutlineInputBorder()),
    );

Widget defaultButton(
{
  required VoidCallback? onPressed,
  required String text,
}
    ) => Container(
  child: MaterialButton(
  onPressed: onPressed,
  child: Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
  color: PrimaryColor,
  textColor: Colors.white,
),
  width: double.infinity,
  height: 50,
);

void showToast({
  required String text,
  required var color,
  var textColor
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: textColor == null ? Colors.white : textColor,
    fontSize: 16.0
);

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


// const packages:


 //  flutter_bloc: ^8.1.1
 // bloc: ^8.1.0
 // dio: ^4.0.6
 // conditional_builder_null_safety: ^0.0.6
 // shared_preferences: ^2.0.15
 // fluttertoast: ^8.1.2
