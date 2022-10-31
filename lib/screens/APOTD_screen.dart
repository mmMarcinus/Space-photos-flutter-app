import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/screens/APOD_widget.dart';
import 'package:space_pictures_app/screens/chosen_day_APOTD.dart';

class APOTD_Screen extends StatefulWidget {
  const APOTD_Screen({Key? key}) : super(key: key);

  @override
  State<APOTD_Screen> createState() => _APOTD_ScreenState();

  static const routeName = '/apotd';
}

//
// TODO ZROBIC APOD POD TEGO SCREENA A POTEM WIDGETY
//
//

class _APOTD_ScreenState extends State<APOTD_Screen> {
  final DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<NasaAPI>(context);
    String apodUrl = '';
    String apodInfo = '';
    final date = '${todayDate.day}-${todayDate.month}-${todayDate.year}';
    //final apiData = apodProvider.getAPODdata();
    return FutureBuilder(
      future: apodProvider.getAPODdata(todayDate).then((_) {
        apodUrl = apodProvider.apod!.imageUrl;
        apodInfo = apodProvider.apod!.imageInfo;
      }),
      builder: (context, asyncSnapshot) {
        return asyncSnapshot.connectionState == ConnectionState.done
            ? DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(CupertinoIcons.back,
                          color: Color(0xff212529)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: const Text(
                      'A P O D',
                      style: TextStyle(color: Color(0xff212529)),
                    ),
                    centerTitle: true,
                    backgroundColor: const Color(0xfff8f9fa),
                  ),
                  body: SafeArea(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        TabBar(
                            onTap: (indicator) {
                              if (indicator == 1) {}
                            },
                            unselectedLabelColor: Colors.black,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const LinearGradient(
                                  transform: GradientRotation(1.2),
                                  colors: <Color>[Colors.blue, Colors.purple]),
                            ),
                            tabs: const [
                              SizedBox(
                                height: 25,
                                width: double.infinity,
                                child: Center(
                                  child: Text('Today'),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                width: double.infinity,
                                child: Center(child: Text('Choose')),
                              ),
                            ]),
                        Expanded(
                            child: TabBarView(children: [
                          APODWidget(apodUrl, apodInfo),
                          const ChosenDayAPODT()
                        ]))
                      ],
                    ),
                  ),
                ),
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
                      const SizedBox(
                        height: 30,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
