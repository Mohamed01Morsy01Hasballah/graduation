import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation/constants/constants.dart';

import '../Models/books_model.dart';

import '../Models/QuestionModel.dart';
//code create by morsy;

Widget BuiltTextField(
    {
      required String label,
      required TextInputType  type,
      required TextEditingController controller,
      required IconData prefix,
      IconData? suffix,
      validate,
      bool secure=false,
      suffixPressed,
      Function? onsubmit,

    }
    )=> TextFormField(
    keyboardType: type,
    controller:controller ,
    obscureText: secure,
    onFieldSubmitted:(s){
      onsubmit!(s);
    } ,
    decoration: InputDecoration(
        labelText:label,

        prefixIcon: Icon(
            prefix
        ),
        suffixIcon: TextButton(
          onPressed:suffixPressed ,
          child: Icon(
              suffix
          ),
        ),
        border:OutlineInputBorder()
    ),
    validator: validate
);

Widget BuiltButton(
    {
       double? height,
       Color? color,
      required String name,
      required  Function function,
    }
    )=>
    Container(
      width: double.infinity,
      height: 50,
      color: defaultColor,
      child: MaterialButton(
        onPressed:(){
          function();
        },
        child: Text(name.toUpperCase()),

      ),
    );



void navigateFininsh({
  Widget ,
  context
})=>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context)=>Widget)
        ,(route) => false
    );
void navigatePush({
  required Widget widget,
  context
})=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));


//code Button


//Code DropDown
