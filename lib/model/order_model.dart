

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';

class OrderModel{
  final String orderKey;
  final String store;
  final String menu; // 가격 or 메뉴
  final String time; // 8:30 ~ 9:30 , 11:00 ~ 12:00
  final String madeTime;
  final String goal; // 미르관 1층, N4 1층 , 스타트업빌리지 305
  final String orderer; // 주문자 닉네임 ex. luke, 강냉 등등
  final String phone; // 주문자 폰 번호
  final String process; // ready, doing, done

  final DocumentReference reference;

  OrderModel.fromMap(Map<String, dynamic> map, {this.reference})
      : orderKey = map[KEY_ORDERKEY],
        store = map[KEY_ORDERSTORE],
        menu = map[KEY_ORDERMENU],
        time = map[KEY_ORDERTIME],
        madeTime = map[KEY_MADETIME],
        goal = map[KEY_ORDERGOAL],
        orderer = map[KEY_ORDERER],
        phone = map[KEY_PHONENUMBER],
        process = map[KEY_PROCESS];

  OrderModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreateOrder({
    String orderKey,
    String store,
    String menu,
    String time,
    String goal,
    String orderer,
    String phone
  }){
    Map<String, dynamic> map = Map();

    DateTime now = DateTime.now();

    map[KEY_ORDERKEY] = orderKey;
    map[KEY_ORDERSTORE] = store;
    map[KEY_ORDERMENU] = menu;
    map[KEY_ORDERTIME] = time;
    map[KEY_MADETIME] = DateTime(now.year, now.month, now.day, now.hour, now.minute).toString();
    map[KEY_ORDERGOAL] = goal;
    map[KEY_ORDERER] = orderer;
    map[KEY_PHONENUMBER] = phone;
    map[KEY_PROCESS] = 'ready';

    return map;
  }

}