import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:graduation_project/core/widgets/hide_keyboard.dart';
import 'package:graduation_project/core/widgets/will_pop.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/login/ui/background.dart';
import 'package:graduation_project/features/login/ui/facebook_signin.dart';
import 'package:graduation_project/features/login/ui/google_signin.dart';

import '../../../core/theming/style_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _unfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: ExitConfirmation(
        child: Scaffold(
          backgroundColor: ColorsManager.mainGreen,
          body: Background(
            showCloseButton: false,
            customContent: Column(
              children: [
                verticalSpace(26.h),
                Container(
                  width: 50.w,
                  height: 6.sp,
                  decoration: BoxDecoration(
                    color: ColorsManager.secondGreen,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                verticalSpace(20.h),
                Text(
                  "تسجيل الدخول",
                  textAlign: TextAlign.center,
                  style: CairoTextStyles.extraBold.copyWith(
                      fontSize: 30.sp, color: ColorsManager.secondGreen),
                ),
                verticalSpace(38.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "البريد الألكتروني",
                      textAlign: TextAlign.right,
                      style: CairoTextStyles.extraBold.copyWith(
                          fontSize: 20.sp, color: ColorsManager.secondGreen),
                    ),
                    horizontalSpace(32.sp),
                  ],
                ),
                verticalSpace(12.sp),
                SizedBox(
                  width: 400.w,
                  height: 56.h,
                  child: DarkCustomTextField(
                    textAlign: TextAlign.right,
                    labelText: "أدخل بريدك الألكتروني",
                    borderCircular: 50.sp,
                    controller: emailController,
                    focusNode: emailFocusNode,
                    textColor: ColorsManager.white,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                ),
                verticalSpace(28.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "كلمة المرور",
                      textAlign: TextAlign.left,
                      style: CairoTextStyles.extraBold.copyWith(
                          fontSize: 20.sp, color: ColorsManager.secondGreen),
                    ),
                    horizontalSpace(32.sp),
                  ],
                ),
                verticalSpace(12.sp),
                SizedBox(
                  width: 400.w,
                  height: 56.h,
                  child: DarkCustomTextField(
                    labelText: "ادخل كلمة المرور",
                    borderCircular: 50.sp,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    textColor: ColorsManager.grey,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _unfocus();
                    },
                  ),
                ),
                verticalSpace(20.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    horizontalSpace(32.sp),
                    GestureDetector(
                      onTap: () {
                        _unfocus();
                        context.pushNamed(Routing.forgetPasswordScreen);
                      },
                      child: Text(
                        "نسيت كلمة المرور ؟",
                        textAlign: TextAlign.right,
                        style: CairoTextStyles.extraBold.copyWith(
                            fontSize: 18.sp, color: ColorsManager.mainGreen),
                      ),
                    ),
                  ],
                ),
                verticalSpace(20.sp),
                SizedBox(
                  height: 56.h,
                  width: 400.w,
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushReplacementNamed(
                            context, Routing.homeScreen);
                      } else if (state is LoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is ValidationError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.secondGreen,
                            borderRadius: BorderRadius.circular(50.sp),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 30.w,
                              height: 30.h,
                              child: const CircularProgressIndicator(
                                color: ColorsManager.moreWhite,
                                strokeWidth: 3.5,
                              ),
                            ),
                          ),
                        );
                      }

                      return DarkCustomTextButton(
                        text: 'تسجيل الدخول',
                        textStyle: CairoTextStyles.extraBold.copyWith(
                            fontSize: 20.sp, color: ColorsManager.moreWhite),
                        onPressed: () {
                          _unfocus();
                          final email = emailController.text;
                          final password = passwordController.text;
                          context.read<LoginCubit>().login(email, password);
                        },
                      );
                    },
                  ),
                ),
                verticalSpace(46.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      height: 1.sp,
                      decoration: BoxDecoration(
                        color: ColorsManager.secondGreen,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 21.0.sp),
                      child: Text(
                        "أو سجل بأستخدام",
                        style: CairoTextStyles.black
                            .copyWith(color: ColorsManager.secondGreen),
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 1.sp,
                      decoration: BoxDecoration(
                        color: ColorsManager.secondGreen,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
                verticalSpace(40.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            UserCredential? userCredential =
                            await signInWithFacebook();
                            if (userCredential != null) {
                              context
                                  .pushNamedAndRemoveUntil(Routing.homeScreen);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "عذراً لم نتمكن من التسجيل عبر الفيسبوك")),
                              );
                            }
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorsManager.secondGreen,
                                width: 2.0.w,
                              ),
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                            width: 32.w,
                            height: 32.h,
                            "assets/SVGs/login_screen/logos_facebook.svg"),
                      ],
                    ),
                    horizontalSpace(50.w),
                    GestureDetector(
                      onTap: () async {
                        _unfocus();
                        final userCredential =
                        await signInWithGoogleAndSendData();
                        if (userCredential?.user != null) {
                          context.pushNamedAndRemoveUntil(Routing.homeScreen);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "عذرا، لم يتم التحقق من حسابك على Google."),
                            ),
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorsManager.secondGreen,
                                width: 2.0.w,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/SVGs/login_screen/logos_google.svg",
                            width: 32.w,
                            height: 32.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(32.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _unfocus();
                        context.pushNamed(Routing.signupScreen);
                      },
                      child: Text(
                        "سجل الأن",
                        style: CairoTextStyles.bold.copyWith(
                            fontSize: 18.sp, color: ColorsManager.mainGreen),
                      ),
                    ),
                    horizontalSpace(10),
                    Text(
                      "ليس لديك حساب ؟",
                      style: CairoTextStyles.bold.copyWith(
                          fontSize: 18.sp, color: ColorsManager.secondGreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
