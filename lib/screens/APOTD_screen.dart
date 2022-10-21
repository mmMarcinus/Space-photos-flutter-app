import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/screens/chosen_day_APOTD_screen.dart';

class APOTD_Screen extends StatefulWidget {
  const APOTD_Screen({Key? key}) : super(key: key);

  @override
  State<APOTD_Screen> createState() => _APOTD_ScreenState();

  static const routeName = '/apotd';
}

class _APOTD_ScreenState extends State<APOTD_Screen> {
  final DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<NasaAPI>(context);
    String apodUrl = '';
    String apodInfo = '';
    final date = todayDate.day.toString() +
        '-' +
        todayDate.month.toString() +
        '-' +
        todayDate.year.toString();
    //final apiData = apodProvider.getAPODdata();
    return FutureBuilder(
      future: apodProvider.getAPODdata(todayDate).then((_) {
        apodUrl = apodProvider.apod!.imageUrl;
        apodInfo = apodProvider.apod!.imageInfo;
      }),
      builder: (context, asyncSnapshot) {
        return asyncSnapshot.connectionState == ConnectionState.done
            ? Scaffold(
                appBar: CupertinoNavigationBar(
                  middle: Text(date),
                ),
                body: OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return SafeArea(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'ASTRONOMY PICTURE OF THE DAY:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.black87),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: apodUrl.length > 2
                                      ? InteractiveViewer(
                                          minScale: 0.6,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Image.network(
                                              apodUrl,
                                              fit: BoxFit.fill,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : CircularProgressIndicator(),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(apodInfo),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        ChosenDayAPODTSCreen.routeName);
                                  },
                                  child: Text(
                                    'Click here if you want to see other day\'s APOD',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  )),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else
                      return SafeArea(
                          child: InteractiveViewer(
                        minScale: 0.6,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.network(
                            apodUrl,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: LinearProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ));
                  },
                ))
            : Scaffold(
                body: Center(
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
      },
    );
  }
}
