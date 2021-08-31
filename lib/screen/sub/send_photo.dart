import 'dart:io';

import 'package:camera/camera.dart';
import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';
import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:demo_kai_morning_210303/model/camera_state.dart';
import 'package:demo_kai_morning_210303/model/order_model.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SendPhoto extends StatefulWidget {

  final OrderModel orderModel;

  SendPhoto({this.orderModel});

  CameraState _cameraState = CameraState();

  @override
  _SendPhotoState createState() {
    _cameraState.getReadyToTakePhoto();
    return _SendPhotoState();
  }
}

class _SendPhotoState extends State<SendPhoto> {
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<CameraState>.value(
      value: widget._cameraState,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Consumer<CameraState>(
                builder: (context, cameraState, _){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width,
                        height: size.width,
                        color: Colors.black,
                        child: (cameraState.isReadyToTakePhoto)?
                        _getPreview(cameraState): MyProgressIndicator(),
                      ),
                      Row(
                        children: [
                          Expanded(child:Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: IconButton(
                                iconSize: 30.0,
                                onPressed: (){
                                  cameraState.changeCameraDirection();
                                  setState(() {
                                  });},
                                icon: Icon(Icons.cached)
                            ),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Spacer(flex: 1,),
                          Container(
                            height:100.0,
                            width: 100.0,
                            child: IconButton(
                              icon:Icon(Icons.camera, size: 100.0,),
                              onPressed: (){
//                                if (cameraState.isReadyToTakePhoto) {
//                                  _attemptTakePhoto(cameraState, context);
//                                }
                              },
                            ),
                          ),
                          Spacer(flex: 1,),
                        ],
                      )
                    ],
                  );
                },
              ),
              SizedBox(height:20.0),

//              FlatButton(
//                child: Text('전화걸기 (태영번호)'),
//                onPressed: () async {
//                  String url = 'tel:01062748997';
//                  if(await canLaunch(url)){
//                    await launch(url);
//                  }
//                  else{
//                    throw 'Could not launch ${url}';
//                  }
//                },
//              ),
              FlatButton(
                child: Text('현재 카메라 작동 x \n문자보내기 (현재 번호 : 진호)'),
                onPressed: () async {
                  //_sendSMS("테스트 메시지", [widget.orderModel.phone]);
                  await _sendSMS("음식 맛있게 드세용~~", ['01082610941']);
                  await orderNetwork.changeOrderProcess(orderKey: widget.orderModel.orderKey, process: KEY_DONE);
                  Navigator.pop(context);
                },
              )
            ],
          )
        ),
      ),
    );
  }

  Future<void> _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
              width: size.width,
              height: size.width / cameraState.controller.value.aspectRatio,
              child: CameraPreview(cameraState.controller)),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {


    try{
      final path = join( (await getTemporaryDirectory()).path, '${DateTime.now().millisecondsSinceEpoch}.png');
      final path1 = join(await getExternalStorageDirectory().toString(), '${DateTime.now().millisecondsSinceEpoch}.png');

      await cameraState.controller.takePicture(path);

      File imgFile = File(path);

      print("path:      _______________________ $path");

      ImageGallerySaver.saveFile(imgFile.absolute.path).then((value) async {
        print("value: ______________________ $value");
        await _sendSMS("음식 맛있게 드세용~~", ['01082610941']);
        await orderNetwork.changeOrderProcess(orderKey: widget.orderModel.orderKey, process: KEY_DONE);

      }).catchError((e){print(e);});


      Navigator.of(context).pop();


    } catch(e){
      print(e);
    }


  }

}
