import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';

String changeName(String key_name){

  String name;

  switch(key_name){
    case KEY_CAMTO:
      name = '캄토';
      break;

    case KEY_HUE:
      name = '휴김밥';
      break;

    case KEY_PULBITMARU:
      name = '풀빛마루';
      break;

    default:
      name = '';
      break;
  }

  return name;
}