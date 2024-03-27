import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:project1/login.dart';

class Userpage extends StatefulWidget {
  const Userpage({super.key});

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


//tmp function
  void onIconPressed() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Icon Tapped!'),
        content: Text('You tapped the icon.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.15,
            right: 0,
            child: mainLogo(screenHeight),
          ),
          Positioned(
            //slider의 위치 조정
            top: screenHeight * 0.09,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight / 1.5,
              child: _buildSlider(screenWidth, screenHeight),
            ),
          ),
          Positioned(
            top: screenHeight * 0.695,
            left: screenWidth * 0.30,
            right: screenWidth * 0.30,
            child: _buildProgressBar(screenWidth),
          ),
          Positioned(
            top: screenHeight * 0.8,
            left: 0,
            right: 0,
            child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  folderIcon(screenHeight),
                  uploadIcon(screenHeight),
                  calendarIcon(screenHeight),
                ],
              ),
          )
        ],
      ),
    );
  }

  Text mainLogo(double screenHeight){
    return Text(
      '4cut Diary',
      style: TextStyle(
        fontFamily: 'MainLogo',
        fontSize: screenHeight * 0.045,
      ),
    );

  }
  // Carousel Slider
  Widget _buildSlider(double screenWidth, double screenHeight) {
    return CarouselSlider(
      items: imagePaths.map((imagePath) {
        return GestureDetector(
          onTap : (){
            //여기에 기능 추가
            onIconPressed();
          },
          child: _buildSlideItem(imagePath, screenWidth, screenHeight),
        );
      },).toList(),
      options: CarouselOptions(
        viewportFraction: 1.00,
        height: screenHeight/2,
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

  // Build Slide Item
  Widget _buildSlideItem(
      String imagePath, double screenWidth, double screenHeight) {
    return Container(
      decoration: _buildDecoration(),
      child: ClipRRect(
        child: Container(
          width: screenHeight / 3.2,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage(imagePath, screenWidth, screenHeight),
              Align(
                alignment: Alignment.centerLeft,
                child:_buildText(screenHeight),
              )
            ],
          ),
        ),
      ),
    );
  }

  // BoxDecoration
  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 3,
          offset: (Offset(0,3))
        ),
      ],
    );
  }

  // Build Image Widget
  Widget _buildImage(String imagePath, double screenWidth, double screenHeight) {
    return Image.asset(
      imagePath,
      width: screenHeight/4,
    );
  }

  // Build Text Widget
  Widget _buildText(double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight / 60, left: screenHeight / 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽으로 정렬
        children: [
          Text(
            //날짜 가져오기
            '2022/04/03',
            style: TextStyle(
              fontSize: screenHeight / 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight/200),
          Text(
            //주소 가져오기
            '가로수길',
            style: TextStyle(
              fontSize: screenHeight / 72,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }


  // Build Progress Bar Widget
  Widget _buildProgressBar(double screenWidth) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
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
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFBE98)),
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

  Widget folderIcon(double screenHeight) {
    return IconButton(
      icon: Icon(
        SFSymbols.folder_fill,
        color: Color(0xFFFFBE98),
        size: screenHeight * 0.04,
      ),
      onPressed: onIconPressed, // 호출하려는 함수
    );
  }

  Widget uploadIcon(double screenHeight){
    return IconButton(
      icon: Icon(
        SFSymbols.square_arrow_up,
        color: Color(0xFFFFBE98),
        size: screenHeight * 0.06,
      ),
      onPressed: onIconPressed,
    );
  }

  Widget calendarIcon(double screenHeight) {
    return IconButton(
      icon: Icon(
        SFSymbols.calendar_circle_fill,
        color: Color(0xFFFFBE98),
        size: screenHeight * 0.04,
      ),
      onPressed: onIconPressed,
    );
  }


  // Widget 
}
