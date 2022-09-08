import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pictures_app/screens/signing_screen.dart';
import 'package:space_pictures_app/widgets/home_screen_widgets/apotd_button.dart';
import 'package:space_pictures_app/widgets/home_screen_widgets/pfmr_button.dart';

void modalBottomLogin(BuildContext context) {
  bool isKeyboardOn = true;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      height: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'Your email'),
                        onTap: () {
                          isKeyboardOn = true;
                        },
                        // onEditingComplete: () {
                        //   isKeyboardOn = false;
                        //   print(isKeyboardOn);
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Your password',
                        ),
                        onTap: () {
                          print(isKeyboardOn);
                          isKeyboardOn = true;
                        },
                        // onEditingComplete: () {
                        //   isKeyboardOn = false;
                        //   print(isKeyboardOn);
                        // },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 10),
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                        child: Text('Not signed up? Click here'))
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool signed = false;
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Hello!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'You are not logged in yet',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //obrazek przywitalny

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    ],
                  ),
                ),
              ),

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
