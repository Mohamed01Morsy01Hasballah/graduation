import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constants/constants.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:graduation/constants/Comonent.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../../../constants/Comonent.dart';
import '../../CurvedScreen.dart';
import '../../Schools/SubjectSchool.dart';
import '../../Teacher/ExamsScreen.dart';
import '../../parent/ChildrenScreen.dart';
import '../Register/RegisterScreen.dart';
import 'LoginCubit.dart';
import 'LoginState.dart';

class LoginScreen extends StatelessWidget{
  var email=TextEditingController();
  var pass=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return BlocProvider<LoginCubit>(
     create: (context)=>LoginCubit(),
     child: BlocConsumer<LoginCubit,LoginStates>(
       listener: (context,state){
       //  var cubit=LoginCubit.get(context);
         if(state is LoginSucessState){
           if(state.model.status == 'success')
           {
             QuickAlert.show(
               context: context,
               type: QuickAlertType.success,
               text: state.model.message,
             );
             if(state.model.loginType=='schools') {
               navigateFininsh(context: context, Widget: SubjectSchool());
             }
             else if(state.model.loginType=='parents'){
               navigateFininsh(context: context, Widget: ChildrenScreen());

             }
             else if(state.model.loginType=='teachers'){

               navigateFininsh(context: context, Widget: ExamsScreen());


             }
             else if(state.model.loginType=='students'){
             //  navigateFininsh(context: context, Widget://write here name Screen Student);
              //
             }


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
         var cubit =LoginCubit.get(context);
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
                                 //color: Theme.of(context).primaryColor
                                 color: defaultColor
                                 /*
                                   gradient: LinearGradient(
                                       begin: Alignment.topLeft,
                                       end: Alignment.bottomRight,
                                       colors: [
                                         HexColor('#140529'),
                                         HexColor('#061892')

                                       ]
                                   )

                                  */

                               ),
                               // color:  Theme.of(context).primaryColor,
                             )
                         ),
                       ),
                       Container(
                         color: Colors.white,
                         child: SizedBox(
                           height: 80,
                           child: TextLiquidFill(
                             text: ' SIGN IN ',
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
                               'Login',
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
                               type: TextInputType.text,
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
                                 condition: state is! LoginLoadingState,
                                 builder: (context)=> BuiltButton(
                                     height: 50,
                                     color: Colors.deepOrange,
                                     name: 'Sign',
                                     function: (){

                                     if(formkey.currentState!.validate()){
                                       cubit.LoginData(
                                           email: email.text,
                                           password: pass.text,
                                         registerType: cubit.RegisterType
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
                                   'dont\'t have Acount ',
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
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                       navigatePush(context:context,widget: RegisterScreen());
                                     },
                                     child: Text(
                                       'Register ',
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