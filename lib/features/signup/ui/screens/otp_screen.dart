import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/signup/logic/code_active_cubit/active_code_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveCodeCubit, ActiveCodeState>(
      listener: (context, state) {
        if (state is ActiveCodeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          context.pushNamedAndRemoveUntil(Routing.homeScreen);
        } else if (state is ActiveCodeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return const SignupScreen(
          customContent: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("this is OTP screen")],
          ),
        );
      },
    );
  }
}
