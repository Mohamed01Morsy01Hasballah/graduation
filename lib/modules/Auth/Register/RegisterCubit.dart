import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/UserModel.dart';
import '../../../Network/Remote/DioHelper.dart';
import '../../../Network/endPoints.dart';
import 'RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterinitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  bool secure=true;
  var RegisterType;
  void ChangeRegisterType(value){
    RegisterType=value;
    emit(ChangeRegisterTypeState());
  }
  void changeIcon(){
    secure=!secure;
    emit(RegisterchangeIconState());
  }
  UserModel? login;
  void RegisterData(
      {
        required String name,
        required String email,
        required String password,
        required String RegisterType

      }
      ){
    emit(RegisterLoadingState());
    print('jkhj');
    DioHelper.postData(

        url: 'register',

        query:
        {
          'email':email,
          'password':password,
          'register_type':RegisterType,
          'name':name,


        }
    ).then((value) {
      print('hgfghj');
      login=UserModel.fromJson(value.data);
      print(login!.message);
      emit(RegisterSucessState(login!));
    }).catchError((error){
      print('error ${error.toString()}');
      emit(RegisterErrorState());
    });
  }
}


