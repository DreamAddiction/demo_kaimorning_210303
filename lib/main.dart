import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constant/firestore_keys.dart';

import 'constant/size.dart';
import 'model/camera_state.dart';
import 'model/rider_model_state.dart';
import 'network/rider_network_func.dart';
import 'screen/auth_screen.dart';
import 'screen/home_screen.dart';
import 'model/firebase_auth_state.dart';
import 'widgets/my_progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() {

    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  Widget _currentWidget;

  int now_state = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(size == null){
      size = MediaQuery.of(context).size;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
          value: _firebaseAuthState,
        ),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),
        ),
      ],
      child: Consumer<FirebaseAuthState>(
        builder: (context, firebaseAuthState, _){
          switch(firebaseAuthState.firebaseAuthStatus){
            case FirebaseAuthStatus.signout:
              _currentWidget = AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = HomePage();
              break;
            default:
              _currentWidget = MyProgressIndicator();
              break;
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _currentWidget,
          );
        },
      ),
    );
  }

  void _initUserModel(FirebaseAuthState firebaseAuthState, BuildContext context) async {

    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);

    userModelState.currentStreamSub = riderNetwork.getUserModelStream(firebaseAuthState.user.uid).listen((userModel){
      userModelState.userModel = userModel;
    });

  }

}
