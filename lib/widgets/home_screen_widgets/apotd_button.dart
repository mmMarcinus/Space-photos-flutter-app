import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pictures_app/screens/APOTD_screen.dart';

class APOTDButton extends StatelessWidget {
  const APOTDButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(APOTD_Screen.routeName);
      },
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.pink[300]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.circular(15)),
              child: Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_4tg3fb79.json'),
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(0 / 360),
              child: Center(
                child: const Text(
                  'Picture of\nthe day',
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
