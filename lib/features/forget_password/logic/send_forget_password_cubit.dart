import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_error_model.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_response_model.dart';
import 'package:graduation_project/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:meta/meta.dart';

part 'send_forget_password_state.dart';

class SendForgetPasswordCubit extends Cubit<SendForgetPasswordState> {
  final SendForgetPasswordRepo sendForgetPasswordRepo;

  SendForgetPasswordCubit(this.sendForgetPasswordRepo)
      : super(SendForgetPasswordInitial());

  Future<void> sendForgetPasswordEmail(String email) async {
    emit(SendForgetPasswordLoading());
    final response = await sendForgetPasswordRepo.sendEmailToForgetPass(email);
    if (response is SendForgetPasswordResponseModel) {
      emit(SendForgetPasswordSuccess(message: response.message));
    } else if (response is SendForgetPasswordErrorModel) {
      emit(SendForgetPasswordFailure(errorMessage: response.message));
    } else {
      emit(SendForgetPasswordFailure(errorMessage: "Unexpected error occurred"));
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
