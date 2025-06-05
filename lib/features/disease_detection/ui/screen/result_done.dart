import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      customWidget: BlocBuilder<DiseaseCubit, DiseaseState>(
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
                  SizedBox(height: 20.h),

                  SizedBox(height: 30.h),
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
}

///                   ElevatedButton(
//                     onPressed: () {
//                       context.pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorsManager.mainGreen,
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 40.w, vertical: 12.h),
//                     ),
//                     child: Text(
//                       "رجوع",
//                       style: CairoTextStyles.medium.copyWith(
//                         fontSize: 18.sp,
//                         color: ColorsManager.white,
//                       ),
//                     ),
//                   ),
