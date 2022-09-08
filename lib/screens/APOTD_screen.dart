import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:space_pictures_app/models/apodModel.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';
import 'package:provider/provider.dart';

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
    //final apiData = apodProvider.getAPODdata();
    return FutureBuilder(
      future: apodProvider.getAPODdata().then((_) {
        apodUrl = apodProvider.apod!.imageUrl;
        apodInfo = apodProvider.apod!.imageInfo;
      }),
      builder: (context, asyncSnapshot) {
        return asyncSnapshot.connectionState == ConnectionState.done
            ? Scaffold(
                body: SafeArea(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      const SizedBox(height: 40),
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
                          child: InteractiveViewer(
                            minScale: 0.6,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.network(
                                apodUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(apodInfo),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Click here if you want to see other day\'s APOD',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                )),
              )
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
