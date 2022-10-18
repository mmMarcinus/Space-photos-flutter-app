import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserDataScreen extends StatelessWidget {
  bool loggedIn;
  UserDataScreen(this.loggedIn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: loggedIn
            ? CupertinoButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Log out'),
              )
            : Text('You are not logged in yet!'));
  }
}
