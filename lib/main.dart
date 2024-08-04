import 'package:flutter/material.dart';

import 'package:flutter_intershala_application/screens/internship_list_screen.dart';
import 'package:flutter_intershala_application/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internships',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => InternshipListScreen(),
        '/splash': (context) => SplashScreen(),
      },
    );
  }
}
