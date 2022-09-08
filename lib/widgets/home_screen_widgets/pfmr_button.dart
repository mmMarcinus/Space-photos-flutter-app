import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pictures_app/screens/PFMR_screen.dart';

class PFMRButton extends StatelessWidget {
  const PFMRButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PFMR_Screen.routeName);
      },
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.pink[200]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15)),
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/private_files/lf30_whmmdqnm.json'),
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(0 / 360),
              child: Center(
                child: const Text(
                  'Photos of \nMars',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
