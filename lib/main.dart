import 'package:flutter/cupertino.dart';
import 'package:project1/login.dart';
import 'package:project1/userpage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: {
        '/':(context) => Loginpage(),
        '/userpage': (context) => Userpage(), // Replace Userpage with your actual Userpage widget
      },
      title: '4cut Diary',
      initialRoute: '/',
    );
  }
}