import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';
import 'package:space_pictures_app/screens/APOTD_screen.dart';
import 'package:space_pictures_app/screens/mars_rover_screen.dart';
import 'package:space_pictures_app/screens/choose_PFMR_screen.dart';
import 'package:space_pictures_app/screens/main_screen.dart';
import 'package:space_pictures_app/screens/signing_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //WidgetsFlutterBinding.ensureInitialized();
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
    int counter = 0;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NasaAPI>(
              create: (_) => NasaAPI(DateTime.now()))
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: const MainScreen(),
            routes: {
              APOTD_Screen.routeName: (ctx) => const APOTD_Screen(),
              PFMR_Screen.routeName: (ctx) => const PFMR_Screen(),
              SignUpScreen.routeName: (ctx) => const SignUpScreen(),
              MarsRoverScreen.routeName: (ctx) => const MarsRoverScreen(),
            },
          );
        });
  }
}
