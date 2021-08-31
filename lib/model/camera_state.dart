import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraState extends ChangeNotifier {
  CameraController _controller;
  CameraDescription _cameraDescription;
  bool _readyTakePhoto = false;
  int _isfront = 0;

  void dispose() {
    if (_controller != null) _controller.dispose();
    _controller = null;
    _cameraDescription = null;
    _readyTakePhoto = false;
    notifyListeners();
  }

  void changeCameraDirection() async {
    _readyTakePhoto = false;

    List<CameraDescription> cameras = await availableCameras();

    if (_isfront == 0)
      _isfront = 1;
    else _isfront = 0;

    if (cameras != null && cameras.isNotEmpty) {
      setCameraDescription(cameras[_isfront]);
    }

    bool init = false;
    while (!init) {
      init = await initialize();
    }

    _readyTakePhoto = true;
    notifyListeners();
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();
    if (cameras != null && cameras.isNotEmpty) {
      setCameraDescription(cameras[_isfront]);
    }

    bool init = false;
    while (!init) {
      init = await initialize();
    }

    _readyTakePhoto = true;
    notifyListeners();
  }

  void setCameraDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    _controller = CameraController(_cameraDescription, ResolutionPreset.medium);
  }

  Future<bool> initialize() async {
    try {
      await _controller.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  CameraController get controller => _controller;
  CameraDescription get description => _cameraDescription;
  bool get isReadyToTakePhoto => _readyTakePhoto;
}