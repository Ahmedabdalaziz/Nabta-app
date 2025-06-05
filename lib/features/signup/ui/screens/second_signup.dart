import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';
import 'package:pro_kit_snackbar/snack_bar/snack_bar.dart';
import 'package:pro_kit_snackbar/snack_bar/snackbar_enum.dart';

class SecondSignup extends StatefulWidget {
  const SecondSignup({super.key});

  @override
  State<SecondSignup> createState() => _SecondSignupState();
}

class _SecondSignupState extends State<SecondSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isEmailEmpty = false;
  bool isPhoneEmpty = false;

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupContactDetailsUpdated) {
          context.pushNamed(Routing.firstPasswordSignupScreen);
        }
        else if (state is SignupError) {
          _showErrorMessage(
              context,
              title: "خطأ",
              message: state.message
          );
        }
        else if (state is EmailAlreadyExists) {
          _showErrorMessage(
              context,
              title: "تنبيه",
              message: state.message,
              type: ProKitNotificationType.warning
          );
        }
      },
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          final isLoading = state is EmailLoadingCheck;

          return Stack(
            children: [
              SignupScreen(
                customContent: Column(
                  children: [
                    verticalSpace(38.h),
                    _buildFieldLabel("البريد الألكتروني"),
                    verticalSpace(12.sp),
                    _buildEmailField(),
                    verticalSpace(28.h),
                    _buildFieldLabel("رقم الهاتف"),
                    verticalSpace(12.sp),
                    _buildPhoneField(),
                    verticalSpace(275.sp),
                    _buildProgressButton(context),
                  ],
                ),
              ),
              if (isLoading) _buildLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: CairoTextStyles.extraBold.copyWith(
              fontSize: 20.sp,
              color: ColorsManager.secondGreen
          ),
        ),
        horizontalSpace(32.sp),
      ],
    );
  }

  Widget _buildEmailField() {
    return SizedBox(
      width: 400.w,
      height: 56.h,
      child: DarkCustomTextField(
        showError: isEmailEmpty,
        onChanged: (value) => setState(() => isEmailEmpty = value.isEmpty),
        labelText: "أدخل بريدك الألكتروني",
        borderCircular: 50.sp,
        controller: emailController,
        textColor: ColorsManager.white,
      ),
    );
  }

  Widget _buildPhoneField() {
    return SizedBox(
      width: 400.w,
      height: 56.h,
      child: DarkCustomTextField(
        showError: isPhoneEmpty,
        keyboardType: TextInputType.phone,
        labelText: "ادخل رقم الهاتف",
        borderCircular: 50.sp,
        controller: phoneController,
        textColor: ColorsManager.grey,
        onChanged: (value) => setState(() => isPhoneEmpty = value.isEmpty),
      ),
    );
  }

  Widget _buildProgressButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 80.h,
      child: GestureDetector(
        onTap: () => _handleNextButtonTap(context),
        child: CircleProgressBar(
          animationDuration: const Duration(seconds: 1),
          backgroundColor: Colors.grey.shade300,
          foregroundColor: ColorsManager.secondGreen,
          value: 0.50,
        ),
      ),
    );
  }

  void _handleNextButtonTap(BuildContext context) {
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    if (email.isEmpty || phone.isEmpty) {
      setState(() {
        isEmailEmpty = email.isEmpty;
        isPhoneEmpty = phone.isEmpty;
      });
      return;
    }

    context.read<SignupCubit>().validateAndUpdateContactDetails(email, phone);
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorsManager.mainGreen,
        ),
      ),
    );
  }

  void _showErrorMessage(BuildContext context, {
    required String title,
    required String message,
    ProKitNotificationType type = ProKitNotificationType.failure
  }) {
    showProKitSnackBar(
      context,
      title: title,
      titleTextStyle: CairoTextStyles.bold.copyWith(color: ColorsManager.greenWhite),
      message: message,
      snackBarType: ProKitSnackBarType.colored,
      notificationType: type,
      color: type == ProKitNotificationType.warning
          ? Colors.red
          : ColorsManager.mainGreen,
      autoCloseDuration: const Duration(seconds: 5),
      messageTextStyle: CairoTextStyles.bold.copyWith(color: ColorsManager.greenWhite),
    );
  }
}