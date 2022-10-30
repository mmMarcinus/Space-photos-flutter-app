import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/screens/chosen_day_APOTD.dart';

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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: <Widget>[
                        //     IconButton(
                        //       onPressed: () {
                        //         Navigator.of(context).pop();
                        //       },
                        //       icon: const Icon(
                        //         CupertinoIcons.back,
                        //         size: 30,
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //         shape: const StadiumBorder(),
                              //         elevation: 4),
                              //     onPressed: null,
                              //     child: const Padding(
                              //       padding: EdgeInsets.symmetric(
                              //           vertical: 12.0, horizontal: 20),
                              //       child: Text(
                              //         'Today',
                              //         style: TextStyle(fontSize: 25),
                              //       ),
                              //     )),
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //         elevation: 4,
                              //         shape: const StadiumBorder()),
                              //     onPressed: () {},
                              //     child: const Padding(
                              //       padding: EdgeInsets.symmetric(
                              //           vertical: 12.0, horizontal: 15),
                              //       child: Text(
                              //         'Choose',
                              //         style: TextStyle(fontSize: 25),
                              //       ),
                              //     )),
                            ]),
                        Expanded(
                            child: TabBarView(children: [
                          Container(),
                          const ChosenDayAPODT()
                        ]))
                      ],
                    ),
                  ),
                ),
              )
            // ? Scaffold(
            //     appBar: CupertinoNavigationBar(
            //       middle: Text(date),
            //     ),
            //     body: OrientationBuilder(
            //       builder: (context, orientation) {
            //         if (orientation == Orientation.portrait) {
            //           return SafeArea(
            //             child: SingleChildScrollView(
            //               physics: BouncingScrollPhysics(),
            //               child: Column(
            //                 children: <Widget>[
            //                   const SizedBox(height: 30),
            //                   Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: const Text(
            //                       'ASTRONOMY PICTURE OF THE DAY:',
            //                       textAlign: TextAlign.center,
            //                       style: TextStyle(
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: 24,
            //                           color: Colors.black87),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: ClipRRect(
            //                       borderRadius: BorderRadius.circular(15),
            //                       child: apodUrl.length > 2
            //                           ? InteractiveViewer(
            //                               minScale: 0.6,
            //                               child: Container(
            //                                 width: double.infinity,
            //                                 decoration: BoxDecoration(
            //                                     borderRadius:
            //                                         BorderRadius.circular(15)),
            //                                 child: Image.network(
            //                                   apodUrl,
            //                                   fit: BoxFit.fill,
            //                                   loadingBuilder:
            //                                       (BuildContext context,
            //                                           Widget child,
            //                                           ImageChunkEvent?
            //                                               loadingProgress) {
            //                                     if (loadingProgress == null)
            //                                       return child;
            //                                     return Center(
            //                                       child:
            //                                           LinearProgressIndicator(
            //                                         value: loadingProgress
            //                                                     .expectedTotalBytes !=
            //                                                 null
            //                                             ? loadingProgress
            //                                                     .cumulativeBytesLoaded /
            //                                                 loadingProgress
            //                                                     .expectedTotalBytes!
            //                                             : null,
            //                                       ),
            //                                     );
            //                                   },
            //                                 ),
            //                               ),
            //                             )
            //                           : CircularProgressIndicator(),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 15,
            //                   ),
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 12),
            //                     child: Text(apodInfo),
            //                   ),
            //                   SizedBox(
            //                     height: 25,
            //                   ),
            //                   TextButton(
            //                       onPressed: () {
            //                         Navigator.of(context).pushNamed(
            //                             ChosenDayAPODTSCreen.routeName);
            //                       },
            //                       child: Text(
            //                         'Click here if you want to see other day\'s APOD',
            //                         textAlign: TextAlign.center,
            //                         style: TextStyle(fontSize: 18),
            //                       )),
            //                   const SizedBox(
            //                     height: 25,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         } else
            //           return SafeArea(
            //               child: InteractiveViewer(
            //             minScale: 0.6,
            //             child: Container(
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(15)),
            //               child: Image.network(
            //                 apodUrl,
            //                 fit: BoxFit.fill,
            //                 loadingBuilder: (BuildContext context, Widget child,
            //                     ImageChunkEvent? loadingProgress) {
            //                   if (loadingProgress == null) return child;
            //                   return Center(
            //                     child: LinearProgressIndicator(
            //                       value: loadingProgress.expectedTotalBytes !=
            //                               null
            //                           ? loadingProgress.cumulativeBytesLoaded /
            //                               loadingProgress.expectedTotalBytes!
            //                           : null,
            //                     ),
            //                   );
            //                 },
            //               ),
            //             ),
            //           ));
            //       },
            //     ))
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
