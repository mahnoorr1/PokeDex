import 'package:equatable/equatable.dart';

enum SignUpStatus {initial, submit, success, error}
class SignUpState extends Equatable{
  final String email;
  final String pass;
  final SignUpStatus status;
  SignUpState({required this.email, required this.pass, required this.status});
  factory SignUpState.initial(){
    return SignUpState(email: '', pass: '', status: SignUpStatus.initial);
  }

  SignUpState copyWith({
    String? email,
    String? pass,
    SignUpStatus? status, errorMessage
}){
    return SignUpState(email: email?? this.email, pass: pass?? this.pass, status: status?? this.status);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email, pass, status];


}