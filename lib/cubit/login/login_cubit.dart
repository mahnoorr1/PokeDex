import 'package:assessment_1/Auth/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:assessment_1/cubit/login/login_state.dart';

class Login_Cubit extends Cubit<LoginState>{
  final Authentication _auth;
  Login_Cubit(this._auth) : super(LoginState.initial());

  void emailChanged(String mail){
    emit(state.copyWith(email: mail, status: LoginStatus.initial));
  }

  void passChanged(String pass){
    emit(state.copyWith(pass: pass, status: LoginStatus.initial));
  }

  Future<void> Login() async {
    if(state.status == LoginStatus.submit) return;
    emit(state.copyWith(status: LoginStatus.submit));
    try{
      await _auth.login(email: state.email, pass: state.pass);
      emit(state.copyWith(status: LoginStatus.success));
    }catch(_){
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

}