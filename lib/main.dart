
import 'package:carismatic/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:carismatic/ui/splash_screen.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  runApp( MyApp());
}

class MyApp   extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automobile Search',
      home: SplashScreenPage(),
    );
  }
}

