import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraHelper {
  late CameraController controller;
  bool isCameraInitialized = false;
  bool isFlashOn = false;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras.first, ResolutionPreset.high);
    await controller.initialize();
    isCameraInitialized = controller.value.isInitialized;
  }

  void dispose() {
    controller.dispose();
  }

  Future<void> takePicture() async {
    if (!controller.value.isInitialized) return;
    try {
      final XFile image = await controller.takePicture();
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> pickImagee() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {}
  }

  void toggleFlash() async {
    isFlashOn = !isFlashOn;
    await controller.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
  }
}
