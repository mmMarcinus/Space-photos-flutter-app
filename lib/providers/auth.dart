import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  void userRegister(String email, String password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> userLogIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {});
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    }
    return true;
  }
}
