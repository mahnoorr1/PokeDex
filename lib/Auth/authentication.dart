import 'package:assessment_1/models/user.dart';
import 'package:assessment_1/views/login.dart';
import 'package:assessment_1/views/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;


class Authentication {
  final fire_auth.FirebaseAuth _auth;

  Authentication({fire_auth.FirebaseAuth? auth})
      : _auth = auth ?? fire_auth.FirebaseAuth.instance;
  User currentUser = User.empty;
  Stream<User> get user{
    return _auth.authStateChanges().map((firebaseUser){
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });

  }
  Future<void> signup({required String email, required String pass}) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    }catch(_){}
  }
  Future<void> login({required String email, required String pass}) async {
    String errorMessage;
      try{
        fire_auth.UserCredential userCred = await _auth.signInWithEmailAndPassword(email: email, password: pass);
        currentUser = userCred.user as User;

      }on fire_auth.FirebaseAuthException catch  (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        switch (e.code) {
          case "ERROR_INVALID_EMAIL":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "ERROR_WRONG_PASSWORD":
            errorMessage = "Your password is wrong.";
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "ERROR_USER_DISABLED":
            errorMessage = "User with this email has been disabled.";
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            errorMessage = "Too many requests. Try again later.";
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        if (errorMessage != null) {
          return Future.error(errorMessage);
        }
      }

  }
  Future<void> logout() async {
    try{
      await Future.wait([_auth.signOut()]);
    }catch(_){}
  }
}
//to covert the firebase user to our user model
extension on fire_auth.User{
  User get toUser{
    return User(id: uid, name: displayName.toString(), email: email.toString());
  }
}
