import 'package:equatable/equatable.dart';

enum LoginStatus {initial, submit, success, error}
class LoginState extends Equatable{
  final String email;
  final String pass;
  final LoginStatus status;
  const LoginState({required this.email, required this.pass, required this.status});
  factory LoginState.initial(){
    return const LoginState(email: '', pass: '', status: LoginStatus.initial);
  }

  LoginState copyWith({
    String? email,
    String? pass,
    LoginStatus? status,
  }){
    return LoginState(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      status: status ?? this.status,
    );
}

  List<Object> get props => [email, pass, status];
}

