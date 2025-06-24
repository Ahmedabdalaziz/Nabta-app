import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <--- إضافة هذا الاستيراد
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/disease_detection/data/models/plant/plant_disease_detection_models.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
import 'package:pro_kit_snackbar/snack_bar/snack_bar.dart';
import 'package:pro_kit_snackbar/snack_bar/snackbar_enum.dart'; // <--- استيراد الـ Cubit وحالاته

class ResultScreen extends StatelessWidget {
  // <--- لم نعد بحاجة لـ predictionResult في الـ constructor هنا
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightWhite, // لون خلفية الشاشة
      body: SafeArea(
        // <--- استخدام BlocBuilder للاستماع إلى حالة الـ Cubit
        child: BlocBuilder<DiseaseCubit, DiseaseState>(
          builder: (context, state) {
            // حالة النجاح: اعرض النتائج من الـ Cubit
            if (state is DiseaseSuccess) {
              final predictionResult =
                  state.response; // <--- استخراج النتيجة من الحالة
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "فحص النباتات",
                        style: CairoTextStyles.bold.copyWith(
                          fontSize: 22.sp,
                          color: ColorsManager.mainGreen,
                        ),
                      ),
                    ),
                    verticalSpace(30.h),
                    // تمرير النتيجة للدوال المساعدة
                    _buildDiseaseInfoCard(predictionResult),
                    verticalSpace(20.h),
                    _buildSectionTitle("التشخيص:"),
                    verticalSpace(10.h),
                    _buildDiseaseDetailsCard(predictionResult),
                    verticalSpace(20.h),
                    _buildSectionTitle("العلاج:"),
                    verticalSpace(10.h),
                    _buildTreatmentCard(predictionResult),
                    verticalSpace(40.h),
                    _buildActionButtons(context),
                  ],
                ),
              );
            }
            // حالة التحميل: اعرض مؤشر تحميل
            else if (state is DiseaseLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                        color: ColorsManager.mainGreen),
                    verticalSpace(20.h),
                    Text(
                      "جاري فحص النبتة...",
                      style: CairoTextStyles.medium.copyWith(
                        fontSize: 18.sp,
                        color: ColorsManager.mainGreen,
                      ),
                    ),
                  ],
                ),
              );
            }
            // حالة الفشل: اعرض رسالة خطأ
            else if (state is DiseaseFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 60.sp, color: ColorsManager.red),
                      verticalSpace(20.h),
                      Text(
                        "حدث خطأ: ${state.message}\nيرجى المحاولة مرة أخرى.",
                        textAlign: TextAlign.center,
                        style: CairoTextStyles.medium.copyWith(
                          fontSize: 18.sp,
                          color: ColorsManager.red,
                        ),
                      ),
                      verticalSpace(20.h),
                      ElevatedButton(
                        onPressed: () {
                          // يمكنك هنا إعادة محاولة إرسال البيانات
                          // أو العودة للشاشة السابقة
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainGreen,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          "العودة",
                          style: CairoTextStyles.bold.copyWith(
                            fontSize: 16.sp,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            // الحالة الأولية أو أي حالة أخرى غير متوقعة
            return Center(
              child: Text(
                "يرجى التقاط صورة لفحص النبتة.",
                style: CairoTextStyles.medium.copyWith(
                  fontSize: 18.sp,
                  color: ColorsManager.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // الدوال المساعدة تم تعديلها لتستقبل PlantDiseaseDetectionResponseModel
  Widget _buildDiseaseInfoCard(PlantDiseaseDetectionResponseModel result) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            result.name, // اسم المرض بالعربي
            style: CairoTextStyles.bold.copyWith(
              fontSize: 24.sp,
              color: ColorsManager.mainGreen,
            ),
          ),
          verticalSpace(5.h),
          Text(
            result.scientificName, // الاسم العلمي بالإنجليزية
            style: CairoTextStyles.regular.copyWith(
              fontSize: 16.sp,
              color: ColorsManager.grey,
            ),
          ),
          verticalSpace(15.h),
          Row(
            children: [
              Text(
                "نسبة الخطورة:",
                style: CairoTextStyles.medium.copyWith(
                  fontSize: 16.sp,
                  color: ColorsManager.mainGreen,
                ),
              ),
              horizontalSpace(10.w),
              Text(
                result.riskPercentage, // نسبة الخطورة
                style: CairoTextStyles.bold.copyWith(
                  fontSize: 18.sp,
                  color: _getRiskColor(
                      result.riskPercentage), // تحديد اللون بناءً على النسبة
                ),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            children: [
              Text(
                "الدقة:",
                style: CairoTextStyles.medium.copyWith(
                  fontSize: 16.sp,
                  color: ColorsManager.mainGreen,
                ),
              ),
              horizontalSpace(10.w),
              Text(
                result.accuracy, // دقة التنبؤ
                style: CairoTextStyles.bold.copyWith(
                  fontSize: 18.sp,
                  color: ColorsManager.mainGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: CairoTextStyles.bold.copyWith(
        fontSize: 18.sp,
        color: ColorsManager.mainGreen,
      ),
    );
  }

  Widget _buildDiseaseDetailsCard(PlantDiseaseDetectionResponseModel result) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الوصف:",
            style: CairoTextStyles.medium.copyWith(
              fontSize: 16.sp,
              color: ColorsManager.mainGreen,
            ),
          ),
          verticalSpace(5.h),
          Text(
            result.description, // وصف المرض
            style: CairoTextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: ColorsManager.black,
            ),
          ),
          verticalSpace(15.h),
          Text(
            "دورة حياة المرض:",
            style: CairoTextStyles.medium.copyWith(
              fontSize: 16.sp,
              color: ColorsManager.mainGreen,
            ),
          ),
          verticalSpace(5.h),
          Text(
            result.lifeCycle,
            style: CairoTextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: ColorsManager.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentCard(PlantDiseaseDetectionResponseModel result) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            result.treatment, // العلاج
            style: CairoTextStyles.regular.copyWith(
              fontSize: 14.sp,
              color: ColorsManager.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              print("إرسال رسالة للطبيب");
              showProKitSnackBar(
                context,
                title: "هنالك مشكلة ما",
                titleTextStyle: CairoTextStyles.bold
                    .copyWith(color: ColorsManager.greenWhite),
                message:
                    "ارسال رسالة الي الطبيب قيد التنفيذ، سيتم التواصل معك قريباً.",
                snackBarType: ProKitSnackBarType.colored,
                notificationType: ProKitNotificationType.warning,
                color: ColorsManager.mainGreen,
                autoCloseDuration: const Duration(seconds: 2),
                messageTextStyle: CairoTextStyles.bold
                    .copyWith(color: ColorsManager.greenWhite),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainGreen,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              "إرسال رسالة للطبيب",
              style: CairoTextStyles.bold.copyWith(
                fontSize: 16.sp,
                color: ColorsManager.white,
              ),
            ),
          ),
        ),
        horizontalSpace(15.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.pushReplacementNamed(Routing.homeScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainGreen,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              "العودة",
              style: CairoTextStyles.bold.copyWith(
                fontSize: 16.sp,
                color: ColorsManager.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // دالة مساعدة لتحديد لون نسبة المخاطرة
  Color _getRiskColor(String riskPercentage) {
    // إزالة علامة النسبة المئوية وتحويل النص إلى رقم
    final percentage = double.tryParse(riskPercentage.replaceAll('%', ''));
    if (percentage == null)
      return ColorsManager.grey; // لون افتراضي لو فيه مشكلة

    if (percentage > 70) {
      return ColorsManager.red; // أحمر للمخاطر العالية جداً
    } else if (percentage > 40) {
      return ColorsManager.orange; // برتقالي للمخاطر المتوسطة
    } else if (percentage > 10) {
      return ColorsManager.mainGreen; // أخضر داكن للمخاطر المنخفضة
    } else {
      return ColorsManager.mainGreen; // أخضر عادي لو مفيش مخاطرة (صحة جيدة)
    }
  }
}
