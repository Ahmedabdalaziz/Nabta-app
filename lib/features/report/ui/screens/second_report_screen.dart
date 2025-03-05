import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:graduation_project/features/report/logic/report_cubit.dart';
import 'package:graduation_project/features/report/ui/screens/report_screen.dart';
import 'package:graduation_project/features/report/ui/widgets/map.dart';
import 'package:graduation_project/features/report/ui/widgets/name_with_phone.dart';
import 'package:latlong2/latlong.dart';

class SecondReportScreen extends StatefulWidget {
  const SecondReportScreen({super.key});

  @override
  State<SecondReportScreen> createState() => _SecondReportScreenState();
}

class _SecondReportScreenState extends State<SecondReportScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  LatLng? currentLocation;

  @override
  Widget build(BuildContext context) {
    return ReportScreen(
      details: false,
      location: true,
      customWidget: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("اسم المسؤول عن الحالة",
                        style: CairoTextStyles.bold.copyWith(
                            fontSize: 24.sp, color: ColorsManager.secondGreen)),
                  ],
                ),
                verticalSpace(22.h),
                NameWithPhone(
                  controller: nameController,
                  name: "احمد عبد العزيز",
                  option: "اضف اسم اخر",
                  keyboardType: TextInputType.name,
                  labelString: "إدخال الاسم الثلاثي",
                ),
                verticalSpace(22.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("رقم هاتف المسؤول عن الحالة",
                        style: CairoTextStyles.bold.copyWith(
                            fontSize: 24.sp, color: ColorsManager.secondGreen)),
                  ],
                ),
                verticalSpace(22.h),
                NameWithPhone(
                  controller: phoneController,
                  name: "01221039065",
                  option: "اضف رقم اخر",
                  keyboardType: TextInputType.phone,
                  labelString: "إدخل رقم الهاتف",
                ),
                verticalSpace(22.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("عنوان الحالة بالتفصيل",
                        style: CairoTextStyles.bold.copyWith(
                            fontSize: 24.sp, color: ColorsManager.secondGreen)),
                  ],
                ),
                verticalSpace(22.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: DarkCustomTextField(
                    controller: addressController,
                    borderWides: 1,
                    borderColor: ColorsManager.mainGreen,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {},
                    autofocus: false,
                    fillColor: ColorsManager.lightWhite,
                    labelText: "أين يقع مكان الحالة ؟",
                    maxLines: 6,
                    textColor: ColorsManager.secondGreen,
                  ),
                ),
                verticalSpace(22.h),
                MapScreen(
                  onLocationSelected: (LatLng location) {
                    setState(() {
                      currentLocation = location;
                    });
                    context
                        .read<ReportCubit>()
                        .updateLocation(location.latitude, location.longitude);
                  },
                ),
                verticalSpace(12.h),
                SvgPicture.asset("assets/SVGs/home/location order.svg"),
                verticalSpace(32.h),
                Center(
                  child: SizedBox(
                    width: 400.w,
                    height: 70.h,
                    child: DarkCustomTextButton(
                      textStyle: CairoTextStyles.extraBold.copyWith(
                          color: ColorsManager.white, fontSize: 26.sp),
                      text: "التالي",
                      onPressed: () {
                        try {
                          context.read<ReportCubit>().updateContactInformation(
                                nameController.text,
                                phoneController.text,
                                addressController.text,
                              );

                          context.read<ReportCubit>().submitReport();

                          context.pushNamed(Routing.doneReportScreen);
                        } catch (e) {
                          print(e);
                        }
                      },
                      bottomColor: ColorsManager.mainGreen.withOpacity(0.3),
                    ),
                  ),
                ),
                verticalSpace(64.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
