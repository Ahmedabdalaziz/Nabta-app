import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/chat/logic/chat_cubit.dart';
import 'package:graduation_project/features/chat/ui/widgets/after_sending_message.dart';
import 'package:graduation_project/features/chat/ui/widgets/chat_input_field.dart';
import 'package:graduation_project/features/chat/ui/widgets/message_bubble.dart';
import 'package:graduation_project/features/chat/ui/widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showInitialMessage = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {
      _showInitialMessage =
          _controller.text.isEmpty && !FocusScope.of(context).hasFocus;
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    _showInitialMessage = _controller.text.isEmpty && !isKeyboardOpen;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsManager.white,
      body: Stack(
        children: [
          Image.asset(
            "assets/SVGs/home/مقاس موبايلي (1).png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Row(
              children: [
                horizontalSpace(15.w),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorsManager.mainGreen.withOpacity(0.05),
                    radius: 26.r,
                    child: SvgPicture.asset(arrowBack),
                  ),
                ),
                horizontalSpace(145.w),
                Text(
                  "AI نبتة",
                  style: CairoTextStyles.bold.copyWith(
                    fontSize: 28.sp,
                    color: ColorsManager.mainGreen,
                  ),
                ),
                horizontalSpace(135.w),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: ColorsManager.mainGreen.withOpacity(0.05),
                    radius: 26.r,
                    child: Image.asset(
                      "assets/SVGs/chat/menu_chat.png",
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                )
              ],
            ),
          ),
          BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatSuccess || state is ChatTyping) {
                _scrollToBottom();
              }
            },
            builder: (context, state) {
              final chatCubit = context.read<ChatCubit>();
              return Positioned.fill(
                top: 150.h,
                bottom: 100.h,
                child: Column(
                  children: [
                    if (_showInitialMessage && chatCubit.messages.isEmpty)
                      Column(
                        children: [
                          const AfterSendMessage(),
                          verticalSpace(64.h),
                          Text(
                            "أسئلة سريعة",
                            style: CairoTextStyles.extraBold.copyWith(
                              fontSize: 16.sp,
                              color: ColorsManager.secondGreen,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: _buildQuickQuestions(context),
                          ),
                        ],
                      ),
                    if (!_showInitialMessage || chatCubit.messages.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: chatCubit.messages.length +
                              (state is ChatTyping ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < chatCubit.messages.length) {
                              final message = chatCubit.messages[index];
                              return MessageBubble(message: message);
                            } else {
                              return const TypingIndicator();
                            }
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 24.h,
            left: 0,
            right: 0,
            child: ChatInputField(
              controller: _controller,
              onSendPressed: () {
                if (_controller.text.isNotEmpty) {
                  context.read<ChatCubit>().sendMessage(_controller.text);
                  _controller.clear();
                  setState(() {
                    _showInitialMessage = false;
                  });
                }
              },
              onMicPressed: () {
                // mic logic
              },
              onAttachPressed: () {
                // attach logic
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickQuestions(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();

    final List<String> suggestions = [
      "أواجه مشكلة في زراعتي",
      "أريد نصائح للعناية بمحاصيلي",
      "لدي سؤال عن طرق الزراعة",
      "أحتاج حل لمشكلة آفات",
    ];

    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: suggestions.map((question) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.whiteWithGreen,
            foregroundColor: ColorsManager.secondGreen,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          ),
          onPressed: () {
            chatCubit.sendMessage(question);
            setState(() {
              _showInitialMessage = false;
            });
          },
          child: Text(
            question,
            style: CairoTextStyles.bold.copyWith(fontSize: 14.sp),
          ),
        );
      }).toList(),
    );
  }
}
