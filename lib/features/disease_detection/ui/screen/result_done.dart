import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
import 'package:graduation_project/features/disease_detection/ui/screen/background_camera.dart';

class ResultDone extends StatefulWidget {
  const ResultDone({super.key});

  @override
  State<ResultDone> createState() => _ResultDoneState();
}

class _ResultDoneState extends State<ResultDone> {
  @override
  void initState() {
    context.read<DiseaseCubit>().submitDiseaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCamera(
      customWidget: Column(children: [
        Text("جاري فحص النباتات",)
      ],),
    );
  }
}
