import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/chat/data/message_model.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: _buildMessageContent(),
    );
  }

  Widget _buildMessageContent() {
    final message = widget.message;
    return Column(
      crossAxisAlignment:
      message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          // *** التعديل هنا: استخدام CrossAxisAlignment.end للمستخدم لجعل الصورة تبدأ من الأسفل ***
          crossAxisAlignment:
          message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              Padding(
                // يمكنك تعديل هذا البادينج إذا كانت صورة AI بحاجة إلى تعديل أيضًا
                padding: EdgeInsets.only(right: 8.w),
                child: Image.asset(
                  'assets/SVGs/chat/NabtaAi.png',
                  width: 40.w,
                  height: 40.h,
                ),
              ),
            Flexible(
              child: Container(
                // *** التعديل هنا: تقليل أو إزالة الـ top margin لفقاعة المستخدم إذا لزم الأمر ***
                // لجعل الفقاعة ترتفع قليلاً لتتناسب مع الصورة التي تم خفضها
                margin: EdgeInsets.only(
                  top: message.isUser ? 0 : 8.h, // إذا كان مستخدم، لا تضع توب مارجن
                  bottom: 4.h,
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: message.isUser
                      ? ColorsManager.secondGreen
                      : ColorsManager.mainGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(message.isUser ? 20.r : 0),
                    topRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(message.isUser ? 0 : 20.r),
                  ),
                ),
                child: Text(
                  message.text,
                  style: CairoTextStyles.medium.copyWith(
                    fontSize: 18.sp,
                    color: message.isUser
                        ? ColorsManager.white
                        : ColorsManager.secondGreen,
                  ),
                ),
              ),
            ),
            if (message.isUser)
              Padding(
                // *** التعديل هنا: أضف padding علوي لتنزيل الصورة أكثر ***
                padding: EdgeInsets.only(left: 8.w, top: 0.h), // يمكنك تعديل 0.h إلى قيمة أكبر مثل 8.h أو 10.h
                child: Image.asset(
                  'assets/SVGs/chat/UserChatImage.png',
                  width: 40.w,
                  height: 40.h,
                ),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            right: message.isUser ? 50.w : 0,
            left: message.isUser ? 0 : 50.w,
          ),
          child: Text(
            message.time,
            style: CairoTextStyles.medium.copyWith(
              fontSize: 12.sp,
              color: message.isUser
                  ? ColorsManager.secondGreen
                  : ColorsManager.mainGreen,
            ),
          ),
        ),
      ],
    );
  }
}