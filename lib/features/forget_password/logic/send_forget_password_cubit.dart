import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_error_model.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_response_model.dart';
import 'package:graduation_project/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:graduation_project/features/forget_password/data/model/active_forget_password/forget_password_error_activation_code.dart';
import 'package:graduation_project/features/forget_password/data/repo/forget_active_code_repo.dart';
import 'package:meta/meta.dart';

part 'send_forget_password_state.dart';

class SendForgetPasswordCubit extends Cubit<SendForgetPasswordState> {
  final SendForgetPasswordRepo sendForgetPasswordRepo;
  final ForgetActiveCodeRepo forgetActiveCodeRepo;

  SendForgetPasswordCubit({
    required this.sendForgetPasswordRepo,
    required this.forgetActiveCodeRepo,
  }) : super(SendForgetPasswordInitial());

  // إرسال الإيميل للحصول على كود OTP
  Future<void> sendForgetPasswordEmail(String email) async {
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emit(ValidationError(message: "يرجى إدخال بريد إلكتروني صالح"));
      return;
    }

    emit(SendForgetPasswordLoading());
    final response = await sendForgetPasswordRepo.sendEmailToForgetPass(email);
    if (response is SendForgetPasswordResponseModel) {
      emit(SendForgetPasswordSuccess(message: response.message));
    } else if (response is SendForgetPasswordErrorModel) {
      emit(SendForgetPasswordFailure(errorMessage: response.message));
    } else {
      emit(SendForgetPasswordFailure(errorMessage: "حدث خطأ غير متوقع"));
    }
  }

  // التحقق من كود OTP
  Future<void> verifyOtpCode(String email, String otpCode) async {
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emit(ValidationError(message: "بريد إلكتروني غير صالح"));
      return;
    }
    if (otpCode.isEmpty || otpCode.length < 4) {
      emit(ValidationError(message: "يرجى إدخال كود OTP صالح"));
      return;
    }

    emit(SendForgetPasswordLoading());
    final response = await forgetActiveCodeRepo.getActiveCodeRepo(email, otpCode);

    if (response is ForgetPasswordErrorActivationCodeModel) {
      emit(SendOtpVerificationFailure(errorMessage: response.message));
    } else {
      emit(SendOtpVerificationSuccess(message: "تم التحقق من الكود بنجاح"));
    }
  }
}