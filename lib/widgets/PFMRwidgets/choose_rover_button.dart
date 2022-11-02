import 'package:flutter/material.dart';

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
            onPressed: () {},
            child: Container(
              decoration: const BoxDecoration(),
              height: 80,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Text(
                    roverName,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
