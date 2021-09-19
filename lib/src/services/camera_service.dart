import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraServices {
  static final CameraServices _singleton = CameraServices._internal();

  factory CameraServices() {
    _singleton.getCamera();
    return _singleton;
  }

  late final CameraController _cameraController;

  Future getCamera() async {
    if (await Permission.camera.status != PermissionStatus.granted) {
      await Permission.camera.request();
    }
    final PermissionStatus cameraPermisson = await Permission.camera.status;

    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.

    final firstCamera = cameras.first;
    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
  }

  CameraController getCameraController() {
    return _cameraController;
  }

  CameraServices._internal();
}
