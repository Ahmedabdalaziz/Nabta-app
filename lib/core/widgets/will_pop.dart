import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:pro_kit_snackbar/snack_bar/snack_bar.dart';
import 'package:pro_kit_snackbar/snack_bar/snackbar_enum.dart';

class ExitConfirmation extends StatefulWidget {
  final Widget child;

  const ExitConfirmation({super.key, required this.child});

  @override
  State<ExitConfirmation> createState() => _ExitConfirmationState();
}

class _ExitConfirmationState extends State<ExitConfirmation> {
  bool _showExitMessage = false;

  Future<bool> _onWillPop() async {
    if (_showExitMessage) {
      SystemNavigator.pop();
      return true;
    } else {
      setState(() {
        _showExitMessage = true;
      });

      showProKitSnackBar(
        context,
        title: "هل انت متأكد؟",
        titleTextStyle:
            CairoTextStyles.bold.copyWith(color: ColorsManager.greenWhite),
        message: "اضغط مرة أخرى للخروج",
        snackBarType: ProKitSnackBarType.colored,
        notificationType: ProKitNotificationType.warning,
        color: ColorsManager.mainGreen,
        autoCloseDuration: const Duration(seconds: 5),
        messageTextStyle:
            CairoTextStyles.bold.copyWith(color: ColorsManager.greenWhite),
      );

      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _showExitMessage = false;
      });

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }
}
