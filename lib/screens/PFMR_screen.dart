import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/models/pfmrModel.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';

class PFMR_Screen extends StatefulWidget {
  const PFMR_Screen({Key? key}) : super(key: key);

  @override
  State<PFMR_Screen> createState() => _PFMR_ScreenState();

  static const routeName = '/pfmr';
}

int n1 = 0, n2 = 1, n3 = 2;

class _PFMR_ScreenState extends State<PFMR_Screen> {
  @override
  Widget build(BuildContext context) {
    PFMR? pfmr = null;
    int photosLength = 0;
    final pfmrProvider = Provider.of<NasaAPI>(context);
    return FutureBuilder(
        future: pfmrProvider.getPFMRdata().then((_) {
          pfmr = pfmrProvider.pfmr;
          photosLength = pfmr!.photos.length;
          drawNumbers(photosLength);
          print(pfmr!.photos[3]);
        }),
        builder: (ctx, dataSnapshot) {
          return Scaffold(
            body: dataSnapshot.connectionState == ConnectionState.done
                ? SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const CircleAvatar(
                                radius: 30,
                                child: Icon(Icons.arrow_back_ios_new),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MarsPhoto(pfmr!.photos[n1]['img_src']),
                          MarsPhoto(pfmr!.photos[n2]['img_src']),
                          MarsPhoto(pfmr!.photos[n3]['img_src']),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.rocket_launch_rounded,
                          color: Colors.deepPurple[300],
                          size: 68,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CircularProgressIndicator(),
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
        child: Container(
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
