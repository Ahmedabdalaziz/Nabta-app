import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({super.key});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  void initState() {
    context.read<DiseaseCubit>().submitDiseaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتيجة التحليل'),
      ),
      body: BlocConsumer<DiseaseCubit, DiseaseState>(
        listener: (context, state) {
          if (state is DiseaseFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is DiseaseLoading) {
            return Center(
                child:
                    CircularProgressIndicator(color: ColorsManager.mainGreen));
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
          return Center(
            child: ElevatedButton(
              onPressed: () {
                print('🟢 Submitting data from preview screen...');
              },
              child: const Text('تحليل البيانات'),
            ),
          );
        },
      ),
    );
  }
}
