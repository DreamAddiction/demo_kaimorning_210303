import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';
import 'package:demo_kai_morning_210303/model/camera_state.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/useful/change_name.dart';
import 'package:demo_kai_morning_210303/useful/generate_key.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/size.dart';
import '../../model/firebase_auth_state.dart';

class CreateOrderScreen extends StatefulWidget {


  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();



//  orderKey
//  store
//  menu
//  time
//  madeTime
//  goal
//  orderer // 선택할 수 있게?
//  process

  TextEditingController _storeController = TextEditingController();
  TextEditingController _menuController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _goalController = TextEditingController();
  TextEditingController _ordererController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _storeController.dispose();
    _menuController.dispose();
    _timeController.dispose();
    _goalController.dispose();
    _ordererController.dispose();
    _phoneController.dispose();
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
                    Icon(
                      Icons.directions_car,
                      size: 50.0,
                    ),
                    Text(
                      '신규 주문 등록',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text('시간'),
                    PopupMenuButton<int>(
                      icon: Icon(Icons.assistant_photo),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(value: 0, child: Text('08:30 ~ 09:30')),
                          PopupMenuItem(value: 1, child: Text('11:00 ~ 12:00')),
                        ];
                      },
                      onSelected: (value) {
                        setState(() {
                          if (value == 0)
                            _timeController.text = '08:30 ~ 09:30';
                          else
                            _timeController.text = '11:00 ~ 12:00';
                        });
                      },
                      onCanceled: () {
                        setState(() {
                          _timeController.text = '';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _timeController,
                  decoration: textInputDecor('시간 선택'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text != '') {
                      return null;
                    } else {
                      return '시간을 정해주세요.';
                    }
                  },
                ),
                Row(
                  children: [
                    Text('가게'),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.assistant_photo),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              value: changeName(KEY_CAMTO), child: Text('캄토')),
                          PopupMenuItem(
                              value: changeName(KEY_HUE), child: Text('휴김밥')),
                          PopupMenuItem(
                            value: changeName(KEY_PULBITMARU),
                            child: Text('풀빛마루'),
                          )
                        ];
                      },
                      onSelected: (value) {
                        setState(() {
                          _storeController.text = value;
                        });
                      },
                      onCanceled: () {
                        setState(() {
                          _storeController.text = '';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _storeController,
                  decoration: textInputDecor('가게'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text != '') {
                      return null;
                    } else {
                      return '가게가 비어있습니다.';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('메뉴'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _menuController,
                  decoration: textInputDecor('메뉴'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty) {
                      return null;
                    } else {
                      return '메뉴가 비어있습니다.';
                    }
                  },
                ),

                SizedBox(
                  height: 10.0,
                ),
                Text('수령지'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _goalController,
                  decoration: textInputDecor('수령지'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty) {
                      return null;
                    } else {
                      return '수령지가 비어있습니다.';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('주문자'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _ordererController,
                  decoration: textInputDecor('주문자'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty) {
                      return null;
                    } else {
                      return '주문자가 비어있습니다.';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('폰번호'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: textInputDecor('폰번호'),
                  cursorColor: Colors.black54,
                  validator: (text) {
                    if (text.isNotEmpty && text.length > 8) {
                      return null;
                    } else {
                      return '폰 번호를 입력해주세요';
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
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          print('Validation success!!');
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return MyProgressIndicator();
              },
              isDismissible: false,
              enableDrag: false);

          await orderNetwork.createNewOrder(
              orderKey: generateOrderKey(
                  time: _timeController.text,
                  store: _storeController.text,
                  ordererName: _ordererController.text),
              store: _storeController.text,
              menu: _menuController.text,
              time: _timeController.text,
              goal: _goalController.text,
              orderer: _ordererController.text,
              phone: _phoneController.text);

          Navigator.pop(context);

          Navigator.pop(context);
        }
      },
      child: Text(
        '신규 주문 추가',
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
