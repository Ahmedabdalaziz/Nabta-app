import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/features/disease_detection/ui/widget/camera_bottom_bar.dart';
import 'package:graduation_project/features/disease_detection/ui/widget/camera_helper.dart';
import 'package:graduation_project/features/disease_detection/ui/widget/camera_top_bar.dart';
import 'package:graduation_project/features/disease_detection/ui/widget/custom_toggle_switch.dart';
import 'package:graduation_project/features/disease_detection/ui/widget/plant_selection_widget.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraHelper cameraHelper;
  late Future<void> _cameraInitialization;
  bool _showPlantSelection = true;
  int selectedCategoryIndex = 1;
  XFile? selectedImage;
  String? _capturedImageBase64;
  String? _pickedImageBase64;

  @override
  void initState() {
    super.initState();
    cameraHelper = CameraHelper();
    _cameraInitialization = cameraHelper.initCamera();
  }

  @override
  void dispose() {
    cameraHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _cameraInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainGreen,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error initializing camera: ${snapshot.error}'),
            );
          } else {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(cameraHelper.controller),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 250.h,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.mainGreen.withOpacity(0.3),
                          spreadRadius: 15.r,
                          blurRadius: 700.r,
                          offset: const Offset(0, -10),
                        ),
                      ],
                    ),
                  ),
                ),
                CameraTopBar(
                  isFlashOn: cameraHelper.isFlashOn,
                  onFlashPressed: cameraHelper.toggleFlash,
                ),
                if (_showPlantSelection)
                  PlantSelectionWidget(
                    onSelect: (plantName) {
                      log(plantName);
                      setState(() {
                        _showPlantSelection = false;
                      });
                    },
                  ),
                Positioned(
                  bottom: 150,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomToggleSwitch(
                        selectedIndex: selectedCategoryIndex,
                        onToggle: (index) {
                          setState(() {
                            selectedCategoryIndex = index;
                            _showPlantSelection = index != 0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // محتوى الشاشة
                CameraBottomBar(
                  onCapture: (imageBase64) {
                    setState(() {
                      _capturedImageBase64 = imageBase64;
                    });
                    if (imageBase64 != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImagePreviewScreen(imageBase64: imageBase64),
                        ),
                      );
                    }
                  },
                  onPickImage: (imageBase64) {
                    setState(() {
                      _pickedImageBase64 = imageBase64;
                    });
                    if (imageBase64 != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImagePreviewScreen(imageBase64: imageBase64),
                        ),
                      );
                    }
                  },
                  cameraHelper: cameraHelper,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imageBase64;

  const ImagePreviewScreen({super.key, required this.imageBase64});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Image'),
      ),
      body: Center(
        child: Image.memory(
          base64Decode(imageBase64),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
