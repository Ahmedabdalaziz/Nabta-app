import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
import 'package:graduation_project/features/disease_detection/ui/screen/background_camera.dart';

class ResultDone extends StatefulWidget {
  const ResultDone({super.key});

  @override
  State<ResultDone> createState() => _ResultDoneState();
}

class _ResultDoneState extends State<ResultDone> {
  @override
  Widget build(BuildContext context) {
    return BackgroundCamera(
      customWidget: BlocConsumer<DiseaseCubit, DiseaseState>(
        listener: (context, state) {
          if (state is DiseaseFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "فشل الكشف عن المرض",
                  style: CairoTextStyles.medium.copyWith(
                    color: ColorsManager.red,
                  ),
                ),
                backgroundColor: ColorsManager.white,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DiseaseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DiseaseSuccess) {
            final response = state.response;

            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "✅ تم الكشف عن المرض بنجاح!",
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 22.sp,
                      color: ColorsManager.mainGreen,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildInfoRow("اسم المرض:", response.name),
                  _buildInfoRow("الاسم العلمي:", response.scientificName),
                  _buildInfoRow("نسبة الخطورة:", "${response.riskPercentage}%"),
                  _buildInfoRow("الدقة:", "${response.accuracy}%"),
                  _buildInfoRow("دورة الحياة:", response.lifeCycle),
                  _buildInfoRow("الوصف:", response.description),
                  _buildInfoRow("العلاج:", response.treatment),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainGreen,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 12.h),
                    ),
                    child: Text(
                      "رجوع",
                      style: CairoTextStyles.medium.copyWith(
                        fontSize: 18.sp,
                        color: ColorsManager.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("❌ لم يتم العثور على نتيجة."));
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title ",
            style: CairoTextStyles.bold
                .copyWith(fontSize: 18.sp, color: ColorsManager.black),
          ),
          Expanded(
            child: Text(
              value,
              style: CairoTextStyles.medium
                  .copyWith(fontSize: 16.sp, color: ColorsManager.mainGreen),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
