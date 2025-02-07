import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imageBase64;
  final String plantType;

  const ImagePreviewScreen({
    super.key,
    this.imageBase64 = '',
    this.plantType = '',
  });

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معاينة الصورة'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.memory(
                base64Decode(widget.imageBase64),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocConsumer<DiseaseCubit, DiseaseState>(
            listener: (context, state) {
              if (state is DiseaseFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is DiseaseLoading) {
                return const CircularProgressIndicator();
              } else if (state is DiseaseSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الوصف: ${state.response.description}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'نسبة الخطورة: ${state.response.riskPercentage}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'العلاج: ${state.response.treatment}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  context
                      .read<DiseaseCubit>()
                      .detectDisease(widget.plantType, widget.imageBase64);
                },
                child: const Text('تحليل الصورة'),
              );
            },
          ),
        ],
      ),
    );
  }
}
