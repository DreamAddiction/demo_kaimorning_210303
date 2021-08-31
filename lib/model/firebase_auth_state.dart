import 'package:demo_kai_morning_210303/network/rider_network_func.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 익명 로그인
// UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus =
      FirebaseAuthStatus.signout; // for test

  FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance; // for firebaseAuth instance
  User _firebaseUser; // for connecting userModelState after login/register

  bool _isTeacher = false;

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;

  User get user => _firebaseUser;

  bool get isTeacher => _isTeacher;

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  void register(
      {String email,
      String password,
      String name,
      String nickName,
      String phone}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "회원가입 에러";
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          _message = "패스워드 제대로 넣어주세요";
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = "이메일 주소가 이상합니다.";
          break;
        case 'email-already-in-use':
          _message = "중복된 이메일입니다..";
          break;
      }
      print(_message);
    });

    if (authResult == null) {
      _firebaseUser = null;
      changeFirebaseAuthStatus(FirebaseAuthStatus.signout);
    } else {
      await riderNetwork.createNewRider(
          userKey: authResult.user.uid,
          userName: name,
          userPhone: phone,
          userEmail: email,
          userNickName: nickName);

      _firebaseUser = authResult.user;
      _isTeacher = true;
      changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
    }
  }

  void tryLogin(String id, String pw) async {
    bool flagError = false;
    User user;

    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    // ================= 파이어베이스 처리 ===================
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: id, password: pw);
      user = userCredential.user;

      //todo riders에 속하는 로그인인지 확인.

    } on FirebaseAuthException catch (e) {
      flagError = true;
      if (e.code == 'user-not-found') {
        print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print('Wrong password!');
      }
    }
    // ================= 파이어베이스 처리 ===================

    if (!flagError) {
      changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
      _firebaseUser = user;
      _isTeacher = true;

      notifyListeners();
    } else {
      changeFirebaseAuthStatus(FirebaseAuthStatus.signout);
      notifyListeners();
    }
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;

    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }
}

enum FirebaseAuthStatus { signout, progress, signin }
