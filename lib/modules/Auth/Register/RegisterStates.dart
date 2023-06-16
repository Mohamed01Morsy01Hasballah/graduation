
import '../../../Models/UserModel.dart';

abstract class RegisterStates{}
class RegisterinitialState extends RegisterStates{}
class RegisterchangeIconState extends RegisterStates{}
class ChangeRegisterTypeState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterSucessState extends RegisterStates{
  final UserModel model;
  RegisterSucessState(this.model);
}
class RegisterErrorState extends RegisterStates{}