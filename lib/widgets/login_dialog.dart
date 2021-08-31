import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/size.dart';
import '../model/firebase_auth_state.dart';

class LoginDialog extends StatefulWidget {

  final bool remain_login;
  final FirebaseAuthState firebaseAuthState;

  LoginDialog({this.remain_login, this.firebaseAuthState});

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {

  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  bool remain_login;

  @override
  void initState() {
    remain_login = widget.remain_login;
    _idController.text = 'rider@kaist.ac.kr';
    _pwController.text = '000000';
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: AlertDialog(
              title: Text("라이더 로그인"),
              content: SizedBox(
                width: 250,
                height: 120,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.0,
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(hintText: "아이디"),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      child: TextField(
                        controller: _pwController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: "비밀번호"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 30.0,
                        child: Row(
                          children: [
                            Expanded(child: Container(),),
                            InkWell(
                              onTap: () {
                                remain_login = !remain_login;
                                setState(() {});
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(remain_login
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank),
                                  Text(' 로그인 정보 기억하기', style: TextStyle(fontSize: 10.0))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "로그인",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onPressed: () async {
                    widget.firebaseAuthState
                        .tryLogin(
                        _idController.text, _pwController.text);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    "취소",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )

      ),
    );
  }
}