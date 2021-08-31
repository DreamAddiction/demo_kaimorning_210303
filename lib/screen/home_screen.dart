import 'package:demo_kai_morning_210303/screen/sub/create_order.dart';
import 'package:demo_kai_morning_210303/widgets/body_tab.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:demo_kai_morning_210303/widgets/order_doing_list.dart';
import 'package:demo_kai_morning_210303/widgets/order_done_list.dart';
import 'package:demo_kai_morning_210303/widgets/order_ready_list.dart';
import 'package:flutter/material.dart';
import '../constant/size.dart';
import 'package:provider/provider.dart';

import '../model/firebase_auth_state.dart';
import '../model/rider_model_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  int selectedTap = 0;

  @override
  Widget build(BuildContext context) {


    if(size == null){
      size = MediaQuery.of(context).size;
    }

    return Consumer<UserModelState>(
      builder: (context, userModelState, _){
        if(userModelState == null){
          return MyProgressIndicator();
        }
        else if(userModelState.userModel == null){
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Text('ERROR : 존재하지 않는 유저입니다'),
                  Text('로그인 화면으로 가기'),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: (){
                      Provider.of<FirebaseAuthState>(context, listen: false).signOut();
                      Provider.of<UserModelState>(context, listen: false).clear();
                    },
                  )
                ],
              ),
            ),
          );
        }
        else{
          return SafeArea(
            child: Scaffold(
              key: _drawerKey,
              endDrawer: _drawer(userModelState,context),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('카이모닝', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                                ),
                                Icon(Icons.directions_car, size: 30.0, color: Colors.red,)
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Container(),),
                                IconButton(icon: Icon(Icons.menu, size: 30.0,),onPressed: (){
                                  _drawerKey.currentState.openEndDrawer();
                                },)
                              ],
                            )
                          ],
                        ),
                      ),
                      BodyTab(selectedTab: selectedTap,
                          tab1: () {
                            selectedTap = 0;
                            setState((){});
                          }, tab2 : () {
                            selectedTap = 1;
                            setState((){});
                          }, tab3: () {
                            selectedTap = 2;
                            setState((){});
                          }),
                      Expanded(
                        child: IndexedStack(
                          index: selectedTap,
                          children: [
                            OrderReadyList(),
                            OrderDoingList(),
                            OrderDoneList()
                          ],
                        ),
                      )
                    ],
                  ),
                  (selectedTap == 0)?
                  Positioned(
                    bottom: 30.0,
                    right: 30.0,
                    child: IconButton(
                      icon: Icon(Icons.add_circle_outline, size: 50.0, color: Colors.red,),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateOrderScreen()));
                      },
                    ),
                  ):
                      Container()
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Drawer _drawer(UserModelState userModelState, BuildContext context) {
    return Drawer(
                child: Stack(
                  children: [
                    SizedBox(
                        width: size.width * 0.7,
                        height: size.height,
                        child: Container(
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: size.width * 0.7,
                      height: size.height,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.directions_car),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("라이더 메뉴",
                                          style:
                                          TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Consumer<UserModelState>(
                              builder: (context, userModelState, _){
                                if(userModelState == null){
                                  return MyProgressIndicator();
                                }
                                else if(userModelState.userModel == null){
                                  return MyProgressIndicator();
                                }
                                else{
                                  return Column(
                                    children: [
                                      Text(userModelState.userModel.userEmail),
                                      Text(userModelState.userModel.userName),
                                      Text(userModelState.userModel.userNickName),
                                      Text(userModelState.userModel.userPhone),

                                    ],
                                  );
                                }
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                              child: InkWell(
                                onTap: (){
                                  Provider.of<FirebaseAuthState>(context, listen: false).signOut();
                                  Provider.of<UserModelState>(context, listen: false).clear();
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.exit_to_app, size: 40.0,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "로그아웃",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              );
  }
}
