import 'package:flutter/material.dart';
import 'package:space_pictures_app/screens/mars_rover_screen.dart';

class ChooseRoverButton extends StatelessWidget {
  String roverName;
  ChooseRoverButton(this.roverName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: const Color(0xff212529)),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(MarsRoverScreen.routeName, arguments: roverName);
            },
            child: Container(
              decoration: const BoxDecoration(),
              height: 80,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    roverName,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Hero(
                      tag: roverName,
                      child: const Icon(
                        Icons.rocket,
                        size: 32,
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
