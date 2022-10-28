import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';
import 'package:space_pictures_app/screens/APOTD_screen.dart';
import 'package:space_pictures_app/screens/PFMR_screen.dart';
import 'package:space_pictures_app/screens/chosen_day_APOTD_screen.dart';
import 'package:space_pictures_app/screens/main_screen.dart';
import 'package:space_pictures_app/screens/signing_screen.dart';
import 'package:space_pictures_app/widgets/home_screen_widgets/apotd_button.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// Future<void> backgroundCallback(Uri uri) async {
//   if (uri.host == 'updatecounter') {
//     int counter = 0;
//     await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
//         .then((value) {
//       counter = value!;
//       counter++;
//     });
//     await HomeWidget.saveWidgetData<int>('_counter', counter);
//     await HomeWidget.updateWidget(
//         name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int _counter = 0;

    // void loadData() async {
    //   await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
    //       .then((value) {
    //     _counter = value!;
    //   });
    //   setState(() {});
    // }

    // @override
    // void initState() {
    //   super.initState();
    //   HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    //   loadData(); // This will load data from widget every time app is opened
    // }

    // Future<void> updateAppWidget() async {
    //   await HomeWidget.saveWidgetData<int>('_counter', _counter);
    //   await HomeWidget.updateWidget(
    //       name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
    // }

    // void _incrementCounter() {
    //   setState(() {
    //     // This call to setState tells the Flutter framework that something has
    //     // changed in this State, which causes it to rerun the build method below
    //     // so that the display can reflect the updated values. If we changed
    //     // _counter without calling setState(), then the build method would not be
    //     // called again, and so nothing would appear to happen.
    //     _counter++;
    //   });
    //   updateAppWidget();
    // }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NasaAPI>(
              create: (_) => NasaAPI(DateTime.now()))
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: const MainScreen(),
            routes: {
              APOTD_Screen.routeName: (ctx) => const APOTD_Screen(),
              PFMR_Screen.routeName: (ctx) => const PFMR_Screen(),
              SignUpScreen.routeName: (ctx) => const SignUpScreen(),
              ChosenDayAPODTSCreen.routeName: (ctx) => ChosenDayAPODTSCreen(),
            },
          );
        });
  }
}
