import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/features/forget_password/data/model/active_forget_password/forget_password_response_activation_code.dart';
import 'package:graduation_project/features/forget_password/data/repo/forget_active_code_repo.dart';
import 'package:meta/meta.dart';

part 'email_active_state.dart';

class EmailActiveCubit extends Cubit<EmailActiveState> {
  final ForgetActiveCodeRepo forgetActiveCodeRepo;

  EmailActiveCubit(this.forgetActiveCodeRepo) : super(EmailActiveInitial());

  Future<void> forgetActiveCode(String email, String otpCode) async {
    emit(EmailActiveLoading());
    try {
      final result =
          await forgetActiveCodeRepo.getActiveCodeRepo(email, otpCode);
      if (result is ForgetPasswordResponseActivationCodeModel) {
        emit(EmailActiveSuccess(result.token));
      } else {
        emit(EmailActiveFailure(result.runtimeType()));
      }
    } catch (e) {
      if (e is DioException) {
        emit(
            EmailActiveFailure(e.response?.data["message"] ?? "Network error"));
      } else {
        emit(EmailActiveFailure("Unexpected error: ${e.toString()}"));
      }
    }
  }
}
