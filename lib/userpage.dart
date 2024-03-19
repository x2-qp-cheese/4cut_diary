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

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.18, // 조정 필요
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.5,
              child: _buildSlider(screenWidth, screenHeight),
            ),
          ),
          Positioned(
            top: screenHeight * 0.695,
            left: screenWidth * 0.30,
            right: screenWidth * 0.30,
            child: _buildProgressBar(screenWidth),
          ),
        ],
      ),
    );
  }

  //carouselslider
  Widget _buildSlider(double screenWidth, double screenHeight) {
    return CarouselSlider(
      items: imagePaths.map((imagePath) {
        return _buildSlideItem(imagePath, screenWidth, screenHeight);
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 0.95, // 조정 필요
        aspectRatio: 0.8,
        autoPlay: true,
        enlargeCenterPage: true,
        initialPage: 0,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  
  Widget _buildSlideItem(
      String imagePath, double screenWidth, double screenHeight) {
    return GestureDetector(
      //클릭을 하게 되면 해당 페이지에 해당하는 화면이 뜸
      onTap: () {
        // print("hello");
      },
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: _buildDecoration(),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 250,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage(imagePath, screenWidth, screenHeight),
                _buildText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      // borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

//사진 크기 조정
  Widget _buildImage(
      String imagePath, double screenWidth, double screenHeight) {
    return Image.asset(
      imagePath,
      width: screenWidth / 2,
      height: screenHeight / 3,
    );
  }

  //날짜 등 사진 정보
  Widget _buildText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        '2022/04/03\nhello',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //
  Widget _buildProgressBar(double screenWidth) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(30),
          //   border: Border.all(color: Colors.grey, width: 1),
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 300),
              tween: Tween<double>(
                  begin: 0, end: (_currentIndex + 1) / imagePaths.length),
              builder: (context, value, child) {
                return SizedBox(
                  width: constraints.maxWidth * value,
                  height: 5,
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}