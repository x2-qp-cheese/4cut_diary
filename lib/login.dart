import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '4cut Diary',
              style: TextStyle(
                fontFamily: 'MainLogo',
                fontSize: 200, // Adjust the size as appropriate
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Add some space between the text and the button
            CupertinoButton(
              child: Image.asset('assets/img/kakao_login_medium_wide.png'), // Change 'your_button_image.png' to your actual image path
              onPressed: () {
                signwithKakao();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void signwithKakao() async{
  await dotenv.load(fileName: 'assets/config/.env');
  String? kakaologinkey = dotenv.env['KAKAOLOGIN'];
  KakaoSdk.init(nativeAppKey: kakaologinkey);
  
  if (await isKakaoTalkInstalled()) {
    try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
          return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
      } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
