import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:graduation/modules/Auth/Login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../../constants/Comonent.dart';
import '../../../constants/constants.dart';
import '../../CurvedScreen.dart';
import 'RegisterCubit.dart';
import 'RegisterStates.dart';

class RegisterScreen extends StatelessWidget{
  var email=TextEditingController();
  var pass=TextEditingController();
  var name=TextEditingController();

  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSucessState){
            if(state.model.status == 'success')
            {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: state.model.message,
              );
            }
            else
            {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'Sorry, something went wrong',
              );
            }
          }


        },

        builder:(context,state){
          Size size=MediaQuery.of(context).size;
          var cubit =RegisterCubit.get(context);
          return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: size.height *0.3,
                          width: double.infinity,

                          child: ClipPath(
                              clipper: CurveCliper(),
                              child:Container(
                                decoration: BoxDecoration(
                                    color: defaultColor

                                ),
                              )
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            height: 80,
                            child: TextLiquidFill(
                              text: ' REGISTER ',
                              waveColor: Colors.red,
                              boxBackgroundColor: defaultColor,
                              textStyle: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),

                              boxHeight: 80.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              BuiltTextField(
                                  type: TextInputType.name,
                                  controller: name,
                                  label: 'Name',
                                  prefix: Icons.person,
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return 'Please Enter Name ';
                                    }
                                    return null;

                                  }
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              BuiltTextField(
                                  type: TextInputType.emailAddress,
                                  controller: email,
                                  label: 'Email Address',
                                  prefix: Icons.email,
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return 'Please Enter Email Address';
                                    }
                                    return null;

                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              BuiltTextField(
                                  type: TextInputType.visiblePassword,
                                  controller: pass,
                                  secure: cubit.secure,
                                  label: 'password',
                                  prefix: Icons.lock,
                                  suffix: cubit.secure?Icons.visibility_off:Icons.visibility,
                                  suffixPressed: (){
                                    cubit.changeIcon();
                                  },
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return 'Please Enter Email Address';
                                    }
                                    return null;

                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              FormHelper.dropDownWidgetWithLabel(
                                context,
                                'Choose Type ',
                                'Choose Type',
                                cubit.RegisterType,
                                listType,
                                    (value){
                                  cubit.ChangeRegisterType(value);
                                },
                                    (onValidate){
                                  if(onValidate ==null)
                                    return 'please enter Name ';
                                },
                                optionValue: "id",
                                optionLabel: "name",
                                // hintColor: Colors.white,
                                textColor: Colors.black,
                                //  borderColor: color,


                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context)=> BuiltButton(
                                      height: 50,
                                      color: Colors.deepOrange,
                                      name: 'Register',
                                      function: (){


                                        if(formkey.currentState!.validate()){

                                          cubit.RegisterData(
                                              name: name.text,
                                              email: email.text,
                                              password: pass.text,
                                              RegisterType: cubit.RegisterType
                                          );

                                        }

                                      }
                                  ),

                                  fallback:(context)=>Center(child: CircularProgressIndicator())
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' have Acount ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),

                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                      onPressed: (){

                                        navigatePush(context:context,widget: LoginScreen());
                                      },
                                      child: Text(
                                        'Login ',
                                        style: TextStyle
                                          (
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrangeAccent
                                        ),
                                      ))
                                ],
                              )


                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        } ,

      ),
    );
  }

}