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
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width; // 4:3 비율에 따라 높이 계산
    return CupertinoPageScaffold(
      child: Align(
        child: Container(
          color: Colors.black,
          width: screenWidth,
          height: screenHeight/2,
          child: slider(imagePaths, screenWidth, screenHeight/2),
        ),
      ),
    );
  }

  Widget slider(List<String> images, double sliderWidth,  double sliderHeight) {
    return CarouselSlider(
      items: images.map((imagePath) {
        return Container(
          margin: EdgeInsets.all(2),
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange, // Box color
          ),
          child: Center(
            child: ClipRRect(
              child: Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
              ),
          ),
          )
        );
      }).toList(),
      options: CarouselOptions(
        height: sliderHeight/1.2,
        aspectRatio: 3/4,
        viewportFraction: 0.8,
        autoPlay: true,
        enlargeCenterPage: true,
        initialPage: 0,
      ),
    );
  }
}
