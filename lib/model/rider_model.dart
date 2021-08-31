import 'package:cloud_firestore/cloud_firestore.dart';
import '../constant/firestore_keys.dart';

class RiderModel{
  final String userKey;
  final String userEmail;
  final String userName;
  final String userNickName;
  final String userPhone;

  final DocumentReference reference;

  RiderModel.fromMap(Map<String, dynamic> map, {this.reference})
      : userKey = map[KEY_USERKEY],
        userEmail = map[KEY_USEREMAIL],
        userName = map[KEY_USERNAME],
        userNickName = map[KEY_USERNICKNAME],
        userPhone = map[KEY_USERPHONE];

  RiderModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreateUser({
  String userKey,
    String userEmail,
    String userName,
    String userNickName,
    String userPhone
}){
    Map<String, dynamic> map = Map();
    map[KEY_USERKEY] = userKey;
    map[KEY_USEREMAIL] = userEmail;
    map[KEY_USERNAME] = userName;
    map[KEY_USERNICKNAME] = userNickName;
    map[KEY_USERPHONE] = userPhone;

    return map;
  }

}