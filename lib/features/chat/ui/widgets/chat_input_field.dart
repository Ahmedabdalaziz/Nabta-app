import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart'; // تأكد من استيراد هذا الملف

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSendPressed;
  final VoidCallback? onMicPressed;
  final VoidCallback? onAttachPressed;

  const ChatInputField({
    Key? key,
    required this.controller,
    this.onSendPressed,
    this.onMicPressed,
    this.onAttachPressed,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 30.h, maxHeight: 150.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsManager.mainGreen,
          width: 2.0.sp,
        ),
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainGreen.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.onSendPressed,
            child: SizedBox(
                height: 35.h,
                width: 35.w,
                child: Image.asset("assets/SVGs/chat/send_imo.png")),
          ),
          Expanded(
            child: TextField(
              cursorColor: ColorsManager.mainGreen,
              controller: widget.controller,
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,

              style: CairoTextStyles.bold.copyWith(
                color: ColorsManager.secondGreen,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.right,
              // المحاذاة لليمين للنص المدخل
              decoration: InputDecoration(
                hintText: ' ... اسأل نبتة',
                hintStyle: CairoTextStyles.regular.copyWith(
                  color: ColorsManager.mainGreen,
                  fontSize: 22.sp,
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onSendPressed,
            child: SizedBox(
                height: 35.h,
                width: 35.w,
                child: Image.asset("assets/SVGs/chat/attach_regular.png")),
          ),
          GestureDetector(
            onTap: widget.onSendPressed,
            child: SizedBox(
              height: 35.h,
              width: 35.w,
              child: Image.asset("assets/SVGs/chat/microphone.png"),
            ),
          ),
        ],
      ),
    );
  }
}
