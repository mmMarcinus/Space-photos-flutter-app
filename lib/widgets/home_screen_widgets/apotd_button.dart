import 'package:flutter/material.dart';
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
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(-1, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xfff8f9fa),
            border: Border.all(color: const Color(0xff212529), width: 1)
            // boxShadow: [
            //   BoxShadow(
            //       color: const Color(0xff2e294e), spreadRadius: 2, blurRadius: 0),
            // ],
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  //color: const Color(0xff2e294e),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                'lib/assets/rocket.png',
                fit: BoxFit.cover,
              ),
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(0 / 360),
              child: Center(
                child: const Text(
                  'Picture of\nthe day',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff212529)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
