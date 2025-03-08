import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

TextAlign getTextAlign(String text) {
  final firstChar = text.isNotEmpty ? text.codeUnitAt(0) : 0;
  if (firstChar >= 0x600 && firstChar <= 0x6FF) {
    // Arabic range
    return TextAlign.right;
  } else {
    return TextAlign.left;
  }
}

TextDirection getTextDirection(String text) {
  final firstChar = text.isNotEmpty ? text.codeUnitAt(0) : 0;
  if (firstChar >= 0x600 && firstChar <= 0x6FF) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}

List<String> filterItems(String query, List<String> items) {
  return items
      .where((item) => item.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

class ImageHandler {
  final ImagePicker _picker = ImagePicker();

  // لاختيار صورة من الألبوم
  Future<String?> pickImageFromGalleryAsBase64() async {
    try {
      final XFile? imageFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (imageFile == null) {
        if (kDebugMode) {
          print("No image selected.");
        }
        return null;
      }

      final bytes = await File(imageFile.path).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }
      return null;
    }
  }

  Future<String?> pickImageFromCameraAsBase64() async {
    try {
      final XFile? imageFile =
          await _picker.pickImage(source: ImageSource.camera);
      if (imageFile == null) {
        if (kDebugMode) {
          print("No image captured.");
        }
        return null;
      }

      final bytes = await File(imageFile.path).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      if (kDebugMode) {
        print("Error capturing image: $e");
      }
      return null;
    }
  }
}

String translatedCondition(String condition) {
  return weatherCondition[condition] ?? 'not found';
}

Future<void> requestPermissions() async {
  //storage
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  //camera
  var cameraStatus = await Permission.camera.status;
  if (!cameraStatus.isGranted) {
    await Permission.camera.request();
  }

  //microphone
  var microphoneStatus = await Permission.microphone.status;
  if (!microphoneStatus.isGranted) {
    await Permission.microphone.request();
  }

  //audio
  var audioStatus = await Permission.audio.status;
  if (!audioStatus.isGranted) {
    await Permission.audio.request();
  }

  //location
  var locationStatus = await Permission.location.status;
  if (!locationStatus.isGranted) {
    await Permission.location.status;
  }


}
double translateReqRate (String rate){
  return rateReq[rate]?? 0;
}