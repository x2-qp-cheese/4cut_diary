import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:project1/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: '4cut Diary',
      home: Loginpage(),
    );
  }
}

