
import 'dart:convert';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:graduation/modules/Teacher/AddCourse.dart';
import 'package:graduation/modules/Teacher/ShowCourseScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Models/Teacher/GetCourseModel.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../constants/Comonent.dart';
import '../../constants/constants.dart';
import 'Bloc/Cubit.dart';
import 'Bloc/States.dart';
import 'DrawerTeacher.dart';

class CourseScreen extends StatelessWidget {
  var name=TextEditingController();
  var desc=TextEditingController();
  var available=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CubitTeacher()..GetCourse()..GetProfile(),
      child: BlocConsumer<CubitTeacher,TeacherStates>(
        listener: (context,state){


        if(state is DeleteCourseSuccessState){
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Delete Successful Course',
          );
        }
        if(state is DeleteCourseErrorState){
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'error Invalid',
          );
        }

        },
        builder: (context,state){
          var cubit=CubitTeacher.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('Courses'),
              ),
              drawer: Drawer(
                backgroundColor: defaultColor,
                width: MediaQuery.of(context).size.width *0.55 ,
                child: DrawerItem(),
              ),
              body: ConditionalBuilder(
                  condition: state is! GetCourseLoadingState && state is! GetProfileTeacherLoadingState,
                  builder:(context)=>Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          color: defaultColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(flex:2,child: Text('Name',style: TextStyle(fontSize: 20,color: Colors.white),)),
                                Expanded(flex:1,child: Text('Video ',style: TextStyle(fontSize: 20,color: Colors.white),)),

                                Expanded(flex:1,child: Text('  for ',maxLines:1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 20,color: Colors.white),)),


                                Expanded(
                                    flex:2,
                                    child: Text('Options',style: TextStyle(fontSize: 20,color: Colors.white)))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder:(context,index)=>BuiltItemRow(cubit.getCourseModel!.courses![index],cubit,context) ,
                              separatorBuilder:(context,index)=> SizedBox(height: 10,),
                              itemCount: cubit.getCourseModel!.courses!.length
                          ),
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Spacer(),

                            BuiltContainerButton(
                                function: (){
                                  navigatePush(context:context,widget: AddCourse());

                                },
                                icon: Icons.add,
                                text: 'Add Course'
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  fallback: (context)=>Center(child: CircularProgressIndicator())
              )
          );
        },

      ),
    );
  }
  Widget BuiltContainerButton(
      {
        required  Function function,
        IconData? icon,
        required String text
      }
      ){
    return InkWell(
      onTap: (){
        function();
      } ,
      child: Container(
        height: 40,
        color: Colors.red,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon,color: Colors.white,),
            //SizedBox(width:5 ,),
            Text(text,style:TextStyle(color: Colors.white) ,)
          ],
        ),
      ),
    );
  }

  Widget BuiltItemRow(Courses model,CubitTeacher cubit,context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded( flex :2,child: Text('${model.name}',maxLines:2,overflow:TextOverflow.ellipsis,)),
          Expanded(flex :1,child: Text('${model.videosCount}')),
          Expanded(flex:1,child: Text('${model.forWhich}')),



          Expanded(
            flex: 2,
            child: Row(
              children: [

                Expanded(
                  flex: 1,
                  child: BuiltContainerButton(
                      function: (){
                        cubit.DeleteCourse(id: model.id!);
                      },
                      text: 'Delete'
                  ),
                ),
                SizedBox(width: 5,),
                Expanded
                  (
                  flex: 1,
                  child: BuiltContainerButton(
                      function: (){
                        navigatePush(context:context,widget: ShowCourseScreen(id: model.id!));

                        print(model.id);
                      },
                      text: 'Show'
                  ),
                ),

              ],
            ),
          )


        ],
      ),
    );
  }


}
