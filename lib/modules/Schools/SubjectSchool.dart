import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Models/SchoolSubject.dart';
import 'package:graduation/constants/constants.dart';
import 'package:graduation/modules/Schools/Bloc/Cubit.dart';
import 'package:graduation/modules/Schools/Bloc/States.dart';
import 'package:graduation/modules/Schools/DrawerSchool.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class SubjectSchool extends StatelessWidget {
  const SubjectSchool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SchoolCubit()..GetSubject()..GetProfile(),
      child: BlocConsumer<SchoolCubit,SchoolStates>(
        listener: (context,state){
          if(state is AddSubjectSucessState){
            if(state.model.status=='success'){
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: state.model.message,
              );


            }else {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'The subject id has already been taken.',
              );
            }
          }
          if(state is DeleteSubjectSucessState){
            if(state.model.status=='success'){
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: state.model.message,
              );


            }
          }
        },
        builder: (context,state){
          var cubit=SchoolCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('Subject'),
              ),
              drawer: Drawer(
                backgroundColor: defaultColor,
                width: MediaQuery.of(context).size.width *0.55 ,
                child: DrawerItem(),
              ),
            body: ConditionalBuilder(
                condition: state is! GetSubjectLoadingState && state is! GetProfileSchoolLoadingState,
                builder: (context)=>Padding(
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
                              Text('Name',style: TextStyle(fontSize: 20,color: Colors.white),),
                              Spacer(),
                              Text('Options',style: TextStyle(fontSize: 20,color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder:(context,index)=>BuiltItemRow(cubit.subject!.existsSubjects![index].subject!,cubit.subject!.existsSubjects![index],context) ,
                            separatorBuilder:(context,index)=> SizedBox(height: 10,),
                            itemCount: cubit.subject!.existsSubjects!.length
                        ),
                      ),
                      SizedBox(width: 10,),
                      Row(
                        children: [
                          Spacer(),
                          BuiltContainerButton(
                              function: (){
                                showDialog(context: context, builder: (context)=>
                                    Center(
                                      child: SingleChildScrollView(
                                        child: AlertDialog(
                                          elevation: 20,

                                          backgroundColor: Colors.white,
                                          iconPadding: EdgeInsets.all(0),
                                          contentPadding: EdgeInsets.all(10),

                                          title:ConditionalBuilder(
                                              condition: state is! AddSubjectLoadingState,
                                              builder: (context)=> BuiltContainerButton(function: (){
                                                var id=int.parse(cubit.numberSubject!);

                                                cubit.AddSubject(SubjectId: id);
                                              }, icon: Icons.add, text: 'Add Subject'),
                                              fallback: (context)=>Center(child: CircularProgressIndicator())
                                          ),
                                          content: Container(
                                            //   color: Colors.grey[300],
                                            child: FormHelper.dropDownWidgetWithLabel(
                                              context,
                                              'Choose Subject',
                                              'Choose Subject',
                                              cubit.numberSubject,
                                              listSubject,
                                                  (value){
                                                cubit.numberSubject=value;
                                              },
                                                  (onValidate){
                                                if(onValidate ==null)
                                                  return 'please enter Name Subject';
                                              },
                                              optionValue: "id",
                                              optionLabel: "name",
                                             // hintColor: Colors.white,
                                              textColor: Colors.black,
                                            //  borderColor: color,


                                            ) ,
                                          ),
                                        ),

                                      ),
                                    )
                                );
                              },
                              icon: Icons.add,
                              text: 'Add Subject'
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
    required IconData icon,
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
          children: [
            Icon(icon,color: Colors.white,),
            SizedBox(width:5 ,),
            Text(text,style:TextStyle(color: Colors.white) ,)
          ],
        ),
      ),
    );
  }
  Widget BuiltItemRow(Subject model,ExistsSubjects subject,context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('${model.name}'),
          Spacer(),
          BuiltContainerButton(
              function: (){
                SchoolCubit.get(context).DeleteSubject(id: subject.id!);
              },
              icon: Icons.delete,
              text: 'Delete'
          )
        ],
      ),
    );
  }
}
