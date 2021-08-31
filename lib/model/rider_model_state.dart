
// user 정보가 바뀌면 프로필이나 채팅, 피드 등등의 화면이 재구성 되어야 한다.
// 이 state를 관리해주기 위한 파일이라고 보면됨.

import 'dart:async';

import 'package:flutter/material.dart';
import '../model/rider_model.dart';

class UserModelState extends ChangeNotifier{
  RiderModel _userModel;
  StreamSubscription<RiderModel> _currentStreamSub;

  RiderModel get userModel => _userModel;

  set userModel(RiderModel userModel){
    _userModel = userModel;
    notifyListeners();
  }

  set currentStreamSub(StreamSubscription<RiderModel> currentStreamSub) => _currentStreamSub = currentStreamSub;

  clear() async {
    if(_currentStreamSub != null){
      await _currentStreamSub.cancel(); // cancel은 void 가 아닌 Future<void> 라는 것을 알아야 한다!!
      _currentStreamSub = null;
      _userModel = null;
    }
    _userModel = null;

  }

}