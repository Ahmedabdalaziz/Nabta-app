import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:meta/meta.dart';

part 'send_forget_password_state.dart';

class SendForgetPasswordCubit extends Cubit<SendForgetPasswordState> {
  final SendForgetPasswordRepo sendForgetPasswordRepo;

  SendForgetPasswordCubit(this.sendForgetPasswordRepo)
      : super(SendForgetPasswordInitial());

  void sendEmail(String email) async {
    if (_isEmailValid(email)) {
      emit(SendForgetPasswordLoading());
      try {
        final result = await sendForgetPasswordRepo.sendEmailToForgetPass(email);
        if (result == true) {
          emit(SendForgetPasswordSuccess(message: "Email sent successfully"));
        } else {
          emit(SendForgetPasswordFailure(errorMessage: "Failed to send email"));
        }
      } catch (e) {
        emit(SendForgetPasswordFailure(errorMessage: e.toString()));
      }
    } else {
      emit(ValidationError("Invalid email format"));
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}