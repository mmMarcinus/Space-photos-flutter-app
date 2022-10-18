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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
