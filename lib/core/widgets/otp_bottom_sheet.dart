import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/ID/dependacy_injection.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/signup/logic/code_active_cubit/active_code_cubit.dart';

class OTPBottomSheetWidget extends StatelessWidget {
  final String email;

  const OTPBottomSheetWidget({required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveCodeCubit, ActiveCodeState>(
      listener: (context, state) {
        if (state is ActiveCodeSuccess) {
          Navigator.pushReplacementNamed(context, Routing.homeScreen);
        } else if (state is ActiveCodeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        final codeController = TextEditingController();

        return Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "أدخل كود التفعيل",
                style:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              verticalSpace(20.sp),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  hintText: "كود التفعيل",
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpace(20.sp),
              ElevatedButton(
                onPressed: () {
                  final code = codeController.text.trim();
                  if (code.isNotEmpty) {
                    context
                        .read<ActiveCodeCubit>()
                        .activateAccount(email, code);
                  }
                },
                child: const Text("تفعيل الحساب"),
              ),
            ],
          ),
        );
      },
    );
  }
}
