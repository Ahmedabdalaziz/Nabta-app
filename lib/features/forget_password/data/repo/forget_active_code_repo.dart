import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/forget_password/data/model/active_forget_password/forget_password_error_activation_code.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_request_activation_code.dart';

class ForgetActiveCodeRepo {
  final ApiService apiService;

  ForgetActiveCodeRepo(this.apiService);

  Future<dynamic> getActiveCodeRepo(String email, String otpCode) async {
    final requestModel =
        ActivateAccountRequestModel(email: email, activationCode: otpCode);

    try {
      return await apiService.activateAccount(requestModel);
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          return ForgetPasswordErrorActivationCodeModel.fromJson(response.data);
        } else {
          return ForgetPasswordErrorActivationCodeModel(
              "An unknown error occurred");
        }
      }
      return null;
    }
  }
}
