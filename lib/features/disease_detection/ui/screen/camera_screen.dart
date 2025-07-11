import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
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
  String? _capturedImageBase64;
  String selectedPlant = '';

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
                child:
                    CircularProgressIndicator(color: ColorsManager.mainGreen));
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error initializing camera: ${snapshot.error}'));
          }
          else {
            return BlocConsumer<DiseaseCubit, DiseaseState>(
              listener: (context, state) {
                if (state is DiseaseDataCached) {
                  context.pushNamed(Routing.imagePreviewScreen);
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Positioned.fill(
                        child: CameraPreview(cameraHelper.controller)),
                    CameraTopBar(
                      isFlashOn: cameraHelper.isFlashOn,
                      onFlashPressed: cameraHelper.toggleFlash,
                    ),
                    if (_showPlantSelection)
                      PlantSelectionWidget(
                        onSelect: (plantName) {
                          setState(() {
                            selectedPlant = plantName;
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
                    CameraBottomBar(
                      onCapture: (imageBase64) {
                        if (imageBase64!.isNotEmpty) {
                          context
                              .read<DiseaseCubit>()
                              .cacheDiseaseData(selectedPlant, imageBase64);
                          context.pushNamed(Routing.imagePreviewScreen);
                        } else {}
                      },
                      onPickImage: (imageBase64) {
                        setState(() {
                          _capturedImageBase64 = imageBase64;
                        });
                        if (imageBase64 != null) {
                          context
                              .read<DiseaseCubit>()
                              .cacheDiseaseData(selectedPlant, imageBase64);
                        }
                      },
                      cameraHelper: cameraHelper,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
