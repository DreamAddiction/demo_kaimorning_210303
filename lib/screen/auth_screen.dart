import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/firebase_auth_state.dart';
import '../screen/sub/register_rider.dart';
import '../widgets/login_dialog.dart';
import '../widgets/my_progress_indicator.dart';

import '../constant/size.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  // shared_reference에서 들고오기
  bool remain_id_pw = true;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }

    return Scaffold(
      body: Consumer<FirebaseAuthState>(
        builder: (context, firebaseAuthState, _){
          if (firebaseAuthState == null){
            return MyProgressIndicator();
          }
          else{
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                    color: Colors.black, width: size.width, height: size.height),
                Image.asset(
                  'assets/back_image.gif',
                  width: size.width,
                  fit: BoxFit.fitWidth,
                ),
                Image.asset('assets/black_overlay.png',
                    fit: BoxFit.fill, height: size.height, width: size.width),
                Positioned(
                  top: size.height * 0.3,
                  child: Column(
                    children: [
                      Text(
                        "카이모닝",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "따뜻하고 든든한 아침 챙겨드세요",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: InkWell(
                          onTap: () {
                            // 로그인 관련 dialog 창 띄우기
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginDialog(remain_login: remain_id_pw, firebaseAuthState: firebaseAuthState ,)));
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 20.0),
                                Icon(Icons.directions_car, size: 30.0, color: Colors.red,),
                                Spacer(flex: 1),
                                Text('로그인'),
                                Spacer(flex: 1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage(firebaseAuthState: firebaseAuthState)));
                        },
                        child: Text(
                          "기타 옵션 보기",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

        },
      )
    );
  }

}
