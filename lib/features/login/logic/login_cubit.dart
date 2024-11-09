import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/login/data/models/login_error_model.dart';
import 'package:graduation_project/features/login/data/models/respons_login_model.dart';
import 'package:graduation_project/features/login/data/repo/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(LoginInitial());

  void login(String email, String password) async {
    if (_isEmailValid(email) && _isPasswordValid(password)) {
      emit(LoginLoading());
      try {
        final response = await loginRepository.login(email, password);
        if (response is LoginResponseModel) {
          emit(LoginSuccess());
        } else if (response is LoginErrorModel) {
          emit(LoginError(response.message));
        } else {
          emit(LoginError("Unknown error occurred"));
        }
      } catch (DioException) {
        emit(LoginError("Failed to login: ${DioException.toString()}"));
      }
    } else {
      emit(ValidationError("Invalid email or password format"));
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }
}
