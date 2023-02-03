import 'package:assessment_1/Auth/authentication.dart';
import 'package:assessment_1/cubit/signUp/signUp_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';


class SignupCubit extends Cubit<SignUpState>{
  Authentication _auth;
  SignupCubit(this._auth) : super(SignUpState.initial());

  void emailChanged(String mail){
    emit(state.copyWith(email: mail, status: SignUpStatus.initial));
  }

  void passChanged(String pass){
    emit(state.copyWith(pass: pass, status: SignUpStatus.initial));
  }

  void confirmPassChange(String pass){
    emit(state.copyWith(pass: pass, status: SignUpStatus.initial));
  }

  Future<void> signUp() async{
    if(state.status == SignUpStatus.submit) return;
    emit(state.copyWith(status: SignUpStatus.submit));
    try{
      await _auth.signup(email: state.email, pass: state.pass);
      emit(state.copyWith(status: SignUpStatus.success));
    }on AuthFailed catch (e) {
      emit(
        state.copyWith(
          errorMessage: "Sign up failed",
          status: SignUpStatus.error,
        ),
      );
    }on FirebaseAuthException catch(e){
      emit(
        state.copyWith(
          errorMessage: "Sign up failed",
          status: SignUpStatus.error,
        ),
      );
    }
    catch(_){
      emit(state.copyWith(status: SignUpStatus.error));
    }
  }


}