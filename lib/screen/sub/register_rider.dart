import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/size.dart';
import '../../model/firebase_auth_state.dart';

class RegisterPage extends StatefulWidget {

  final FirebaseAuthState firebaseAuthState;

  RegisterPage({this.firebaseAuthState});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();

  @override
  void initState() {
    _emailController.text = 'rider@kaist.ac.kr';
    _pwController.text = '000000';
    _cpwController.text = '000000';
    _nameController.text = '김태영';
    _nickNameController.text = '카모 라이더';
    _phoneController.text = '01062748997';
    _idNumberController.text = '20180898';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    _nameController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_car, size: 50.0,),
                    Text('라이더 아이디 등록', style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),
                Text('학번'),
                TextFormField(
                  controller: _idNumberController,
                  decoration: textInputDecor('학번'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text.length == 8) {
                      return null;
                    } else {
                      return '학번 8자리가 아닙니다.';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('이름'),
                TextFormField(
                  controller: _nameController,
                  decoration: textInputDecor('이름'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text.length > 1) {
                      return null;
                    } else {
                      return '정확한 성함을 입력해주세요';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),

                Text('휴대폰 번호'),
                TextFormField(
                  controller: _phoneController,
                  decoration: textInputDecor('휴대폰 번호'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text.length > 8) {
                      return null;
                    } else {
                      return '전부 입력해주세요!';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),

                Text('닉네임'),
                TextFormField(
                  controller: _nickNameController,
                  decoration: textInputDecor('닉네임'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text.length > 1) {
                      return null;
                    } else {
                      return '두글자 이상 입력해주세요';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),

                Text('카이스트 메일'),
                TextFormField(
                  controller: _emailController,
                  decoration: textInputDecor('카이스트 메일'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text.contains("@kaist.ac.kr")) {
                      return null;
                    } else {
                      return '정확한 카이스트 이메일 주소를 입력해주세요.';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),

                Text('비번'),
                TextFormField(
                  controller: _pwController,
                  decoration: textInputDecor('비밀번호(6자리 이상)'),
                  cursorColor: Colors.black54,
                  //obscureText: true,
                  validator: (text) {
                    if (text.isNotEmpty && text.length > 2) {
                      return null;
                    } else {
                      return '6자리 이상 입력해주세요!';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('비번 재입력'),
                TextFormField(
                  controller: _cpwController,
                  decoration: textInputDecor('비밀번호 확인'),
                  cursorColor: Colors.black54,
                  //obscureText: true,
                  validator: (text) {
                    if (text.isNotEmpty && _pwController.text == text) {
                      return null;
                    } else {
                      return '입력한 값이 비밀번호와 일치하지 않네요!  입력해주세용~';
                    }
                  },
                ),

                SizedBox(
                  height: 10.0,
                ),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: () {
        if(_formKey.currentState.validate()){
          print('Validation success!!');
          widget.firebaseAuthState.register(email: _emailController.text, password: _pwController.text, name: _nameController.text, nickName: _nickNameController.text, phone:_phoneController.text);
          Navigator.pop(context);
        }
      },
      child: Text(
        '회원가입 신청',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }

  InputDecoration textInputDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: activeInputBorder(),
        focusedBorder: activeInputBorder(),
        errorBorder: errorInputBorder(),
        focusedErrorBorder: errorInputBorder(),
        filled: true,
        fillColor: Colors.grey[100]);
  }

  OutlineInputBorder errorInputBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
        borderRadius: BorderRadius.circular(12.0));
  }

  OutlineInputBorder activeInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[300],
      ),
      borderRadius: BorderRadius.circular(12.0),
    );
  }
}
