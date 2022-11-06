import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/models/pfmrModel.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';

int n1 = 0, n2 = 0, n3 = 0;

class MarsRoverScreen extends StatelessWidget {
  const MarsRoverScreen({Key? key}) : super(key: key);

  static const routeName = '/marsRover';

  @override
  Widget build(BuildContext context) {
    final roverName = ModalRoute.of(context)!.settings.arguments!.toString();
    final pfmrProvider = Provider.of<NasaAPI>(context);
    PFMR? pfmrNavcam;
    PFMR? pfmrFrontHazardAvoidanceCamera;
    PFMR? pfmrRearHazardAvoidanceCamera;
    //     final pfmrProvider = Provider.of<NasaAPI>(context);
    // return FutureBuilder(
    // future: pfmrProvider.getPFMRdata().then((_) {
    //   pfmr = pfmrProvider.pfmr;
    //   photosLength = pfmr!.photos.length;
    //   drawNumbers(photosLength);
    //   print(pfmr!.photos[3]);
    // }),
    //     builder: (ctx, dataSnapshot) {
    return FutureBuilder(
        future: pfmrProvider.getPFMRdata(roverName).then((_) {
          pfmrNavcam = pfmrProvider.pfmr_navcam;
          pfmrFrontHazardAvoidanceCamera = pfmrProvider.pfmr_fhaz;
          pfmrRearHazardAvoidanceCamera = pfmrProvider.pfmr_rhaz;
          //print(pfmrNavcam!.photos);
        }),
        builder: (ctx, dataSnapshot) {
          return dataSnapshot.connectionState == ConnectionState.waiting
              ? Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.rocket_launch_rounded,
                          color: Colors.deepPurple[300],
                          size: 68,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: roverName,
                          child: const Icon(
                            Icons.rocket_launch,
                            size: 1,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(CupertinoIcons.back)),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            roverName,
                            style: const TextStyle(fontSize: 38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: Text('Navigation camera:'),
                        ),
                        MarsPhoto(
                            pfmrRearHazardAvoidanceCamera!.photos[1]['img_src'])
                      ],
                    ),
                  ),
                );
        });
  }
}

class MarsPhoto extends StatefulWidget {
  String img_src;
  MarsPhoto(@required this.img_src, {Key? key}) : super(key: key);
  @override
  State<MarsPhoto> createState() => _MarsPhotoState();
}

class _MarsPhotoState extends State<MarsPhoto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: double.infinity,
          child: InteractiveViewer(
            child: Image.network(
              widget.img_src,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: LinearProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

void drawNumbers(int max) {
  n1 = Random.secure().nextInt(max);
  n2 = Random.secure().nextInt(max);
  n3 = Random.secure().nextInt(max);
  print(n1);
  print(n2);
  print(n3);
}
