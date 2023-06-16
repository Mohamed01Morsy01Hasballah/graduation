import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:graduation/modules/parent/Bloc/Cubit.dart';
import 'package:graduation/modules/parent/Bloc/States.dart';
import 'package:flutter/material.dart';
import 'package:graduation/modules/parent/DrawerParent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../constants/constants.dart';

class ResultChildren extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return BlocProvider(
      create: (context)=>CubitParent()..GetProfile()..GetChildren(),
      child: BlocConsumer<CubitParent,ParentStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=CubitParent.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Result'),
              backgroundColor: defaultColor,

            ),
            drawer: Drawer(
              backgroundColor: defaultColor,
              width: MediaQuery.of(context).size.width *0.55 ,
              child: DrawerItem(),
            ),
            body:ConditionalBuilder(
                condition: state is! GetProfileParentSuccessState && state is! GetChildrenLoadingState,
                builder: (context)=>Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FormHelper.dropDownWidgetWithLabel(
                        context,
                        'Choose Student ',
                        'Choose Student',
                        cubit.idStudent,
                        cubit.listIdStudent,
                            (value){
                          cubit.idStudent=value;
                          var id=int.parse(value);
                          cubit.GetResult(id: id);
                          print(value);
                        },
                            (onValidate){
                          if(onValidate ==null) {
                            return 'please enter name';
                          }
                          return null;
                        },
                        optionValue: "id",
                        optionLabel: "name",
                        // hintColor: Colors.white,
                        textColor: Colors.black,
                        //  borderColor: color,


                      ),
                      SizedBox(height: 15,),
                      if(state is GetResultParentSuccessState)
                        cubit.getResultToParentModel!.results!.length !=0?
                        Text('${cubit.getResultToParentModel!.results![0].result![0].room!.name}')
                            :Text(' '),
                      SizedBox(height: 15,),
                      Container(
                          height: 40,
                          color: defaultColor,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(flex: 2,child: Text('Name Exam ',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),),
                              Expanded(flex: 1,child: Text('Degree Exam ',style: TextStyle(color: Colors.white))),

                            ],
                          )
                      ),
                      SizedBox(height: 8,),
                      if(state is GetResultParentSuccessState)
                        cubit.getResultToParentModel!.results!.length !=0?
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context,index)=>ConditionalBuilder(
                                  condition: state is! GetResultParentSuccessState,
                                  builder: (context)=>  Row(
                                    children: [
                                      Expanded( flex: 2,child: Text('${cubit.getResultToParentModel!.results![0].result![[1]].name}',maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                      Expanded( flex: 1,child: Text('${cubit.getResultToParentModel!.results![0].result![1].resultsdetails![0].studentDegree}/${cubit.getResultToParentModel!.results![0].result![1].resultsdetails![0].subjectDegree}')),

                                    ],
                                  ),
                                  fallback: (context)=>Center(child: CircularProgressIndicator())
                              ),
                              separatorBuilder: (context,index)=>SizedBox(height: 10,),
                              itemCount: cubit.getResultToParentModel!.results![0].result!.length
                          ),
                        ):
                            Text('Not Found Result Student')




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

}
