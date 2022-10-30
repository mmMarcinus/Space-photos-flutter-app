import 'package:flutter/material.dart';
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
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(-1, 3), // changes position of shadow
              ),
            ],
            border: Border.all(width: 1, color: const Color(0xff212529)),
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xfff8f9fa)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                //border: Border.all(width: 1, color: const Color(0xff212529)),
              ),
              child: Image.asset(
                'lib/assets/mar.png',
                fit: BoxFit.cover,
              ),
              // child: Lottie.network(
              //     'https://assets6.lottiefiles.com/private_files/lf30_whmmdqnm.json'),
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(0 / 360),
              child: Center(
                child: const Text(
                  'Photos of \nMars',
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
