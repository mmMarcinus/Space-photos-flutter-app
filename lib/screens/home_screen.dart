import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pictures_app/providers/auth.dart';
import 'package:space_pictures_app/screens/signing_screen.dart';
import 'package:space_pictures_app/widgets/home_screen_widgets/apotd_button.dart';
import 'package:space_pictures_app/widgets/home_screen_widgets/pfmr_button.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class HomeScreen extends StatelessWidget {
  bool loggedIn;
  HomeScreen(@required this.loggedIn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool signed = false;
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: loggedIn
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Hello!',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          !loggedIn ? 'You are not logged in yet' : 'Marcin',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  // loggedIn
                  //     ? Icon(
                  //         Icons.rocket_launch_outlined,
                  //         size: 20,
                  //       )
                  //     // ? Padding(
                  //     //     padding: const EdgeInsets.only(right: 16),
                  //     //     child: CircleAvatar(
                  //     //       radius: 32,
                  //     //       backgroundColor: Colors.pink[100],
                  //     //       child: TextButton(
                  //     //           onPressed: () {}, child: Icon(Icons.person)),
                  //     //     ),
                  //     //   )
                  //     : Container(),
                ],
              ),

              //obrazek przywitalny

              !loggedIn
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[300],
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Lottie.network(
                                    'https://assets4.lottiefiles.com/packages/lf20_jm7mv1ib.json'),
                                width: 140,
                                height: 110,
                                decoration: BoxDecoration(
                                    color: Colors.pink[200],
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Not logged in yet?\nYou can do it here!',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 20),
                                      child: Text('Log in'),
                                    ),
                                    onPressed: () => modalBottomLogin(context),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    )
                  :
                  // TODO: zrobic obrazek po zalogowaniu
                  Container(),

              //zdjecie dnia
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: APOTDButton(),
              ),
              //zdjecia rover z marsa
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PFMRButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void modalBottomLogin(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return LoginModalBottomSheet();
      });
}

class LoginModalBottomSheet extends StatefulWidget {
  const LoginModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<LoginModalBottomSheet> createState() => _LoginModalBottomSheetState();
}

class _LoginModalBottomSheetState extends State<LoginModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Form(
          child: Container(
            height: 350.0,
            color: const Color(
                0xFF737373), //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Your email'),
                      controller: emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your password',
                      ),
                      obscureText: true,
                      onTap: () {},
                      controller: passwordController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        print(FirebaseAuth.instance.currentUser);
                        bool succeded;
                        succeded = await Authentication().userLogIn(
                            emailController.text, passwordController.text);
                        if (succeded) Navigator.pop(context);
                        print(FirebaseAuth.instance.currentUser);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        child: Text(
                          'Log in',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUpScreen.routeName);
                      },
                      child: Text('Not signed up? Click here'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
