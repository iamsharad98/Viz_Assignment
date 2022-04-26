import 'package:flutter/material.dart';
import 'package:viz_sharad_assignment/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'A registration application for arrivals.',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   // textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
      //   //   bodyText1: GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.bodyText1),
      //   // ),
      //   primaryColor: Colors.white,
      // ),
      home: goToScreen(),
    );
  }

  Widget goToScreen(){
    return const HomeScreen();
  }
}

