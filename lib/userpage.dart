import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Userpage extends StatefulWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  final List<String> imagePaths = [
    'assets/img/tmp1.png',
    'assets/img/tmp2.jpg',
    'assets/img/tmp3.png',
    // Add all your image paths here
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Align(
        child: Container(
          color: Colors.black,
          width: screenWidth, 
          height: screenHeight / 3.5,
          child: slider(imagePaths),
        ),
      ),
    );
  }

  Widget slider(List<String> images) {
    return CarouselSlider(
      items: images.map((imagePath) {
        return Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange, // Box color
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              width: 300,
              height: 400,
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        initialPage: 0,
      ),
    );
  }
}
