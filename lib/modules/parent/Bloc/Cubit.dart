

import 'package:bloc/bloc.dart';
import 'package:graduation/Models/Parent/GetAbsenceChildrenModel.dart';
import 'package:graduation/Models/Parent/GetExamChildrenModel.dart';
import 'package:graduation/Models/Parent/GetResultParentModel.dart';
import 'package:graduation/modules/Teacher/Bloc/States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/GetProfileModel.dart';
import '../../../Models/Parent/AddChildrenModel.dart';
import '../../../Models/Parent/GetChildernModel.dart';
import '../../../Network/Remote/DioHelper.dart';
import '../../../constants/constants.dart';
import 'States.dart';


class CubitParent extends Cubit<ParentStates>{
  CubitParent():super(initialParentState());
  static CubitParent get(context)=>BlocProvider.of(context);
  bool value=false;
  void ChangeContainer(){
    value=!value;
    emit(ChangeContainerState());
  }
  GetChildrenModel? getChildren;
  List<dynamic> listIdStudent=[];
  void GetChildren(){
    emit(GetChildrenLoadingState());
    DioHelper.getData(
        url: 'parent/children',
      token: tokenParent
    ).then((value) {
      getChildren=GetChildrenModel.fromJson(value.data);
      emit(GetChildrenSucessState(getChildren!));
      for(int i=0;i<getChildren!.children!.length;i++){
        listIdStudent.add(
          {
            "id":'${getChildren!.children![i].id}',
            "name": '${getChildren!.children![i].name}',
          }
        );
        print(listIdStudent[i]);
      }


    }).catchError((error){
      print('error Get Children $error');
      emit(GetChildrenErrorState());
    });
  }
  AddChildrenModel? addChildren;
  void AddChildren({
  required String email
}){
    emit(AddChildrenLoadingState());
    DioHelper.postData(
        url: 'parent/children',
        token: tokenParent,
        query: {
          'email':email
        }
    ).then((value) {
      addChildren=AddChildrenModel.fromJson(value.data);
      emit(AddChildrenSucessState(addChildren!));
      GetChildren();
    }).catchError((error){
      print('error add children $error');
      emit(AddChildrenErrorState());
    });
  }
  void DeleteChildren({
  required int id
}){
    emit(DeleteChildrenLoadingState());
    DioHelper.DeleteData(
        url:'parent/children/$id',
      token: tokenParent
    ).then((value) {
      emit(DeleteChildrenSucessState());
      GetChildren();
    }).catchError((error){
      print('error delete children $error');
      emit(DeleteChildrenErrorState());
    });
  }

  //Exams
  GetExamsChildrenModel? getExamsChildrenModel;
  void GetExamsStudent(){
    emit((GetExamsChildrenLoadingState()));
    DioHelper.getData(
        url: 'parent/exams',
      token: tokenParent,

    ).then((value) {
      emit((GetExamsChildrenSuccessState()));
      getExamsChildrenModel=GetExamsChildrenModel.fromJson(value.data);
      print('Success');
      print(getExamsChildrenModel!.exams![0].name);
      print(getExamsChildrenModel!.exams![1].examss!.length);


      print(getExamsChildrenModel!.exams![0].examss![0].exam!.name);

    }).catchError((error){
      print('Get exam children $error');
      emit((GetExamsChildrenErrorState()));

    });
  }

  //Absence
  String? idStudent;
  GetAbsenceChildrenModel? getAbsenceChildrenModel;
void GetAbsence({
  required int id
}){
  emit(GetAbsenceChlidrenLoadingState());
    DioHelper.getData(
        url: 'parent/absence',
      token: tokenParent,
      query: {
          'student_id':id
      }

    ).then((value) {
      getAbsenceChildrenModel=GetAbsenceChildrenModel.fromJson(value.data);
      emit(GetAbsenceChlidrenSuccessState());

    }).catchError((error){
      print('error absence children $error');
      emit(GetAbsenceChlidrenErrorState());


    });
}
//Result
  GetResultToParentModel? getResultToParentModel;
GetResult({
    required int id
}){
  emit(GetResultParentLoadingState());
  DioHelper.getData(
      url: 'parent/results',
    token: tokenParent,
    query: {
        'student_id':id
    }
  ).then((value) {
    getResultToParentModel=GetResultToParentModel.fromJson(value.data);
    emit(GetResultParentSuccessState());
    print(getResultToParentModel!.status);

  }).catchError((error){
    emit(GetResultParentErrorState());
    print('error get result parent $error');
  });
}

  //profile
  GetProfileModel? getProfileModel;

  GetProfile() {
    emit(GetProfileParentLoadingState());
    DioHelper.getData(
        url: 'profile/parent',
        token: tokenParent
    ).then((value) {
      getProfileModel=GetProfileModel.fromJson(value.data);
      emit(GetProfileParentSuccessState());
    }).catchError((error) {
      print('error get profilr $error');
      emit(GetProfileParentErrorState());
    });
  }


}