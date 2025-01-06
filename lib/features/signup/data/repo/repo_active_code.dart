import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_error_activation_code.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_request_activation_code.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_response_activation_code.dart';

class ActivateAccountRepository {
  final ApiService apiService;

  ActivateAccountRepository(this.apiService);

  Future<dynamic> activateAccount(String email, String activationCode) async {
    try {
      final request = ActivateAccountRequestModel(
        email: email,
        activationCode: activationCode,
      );

      final response = await apiService.activateAccount(request.toJson());

      return ActivateAccountResponseModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          return ActiveCodeErrorModel.fromJson(response.data);
        }
      }
      return ActiveCodeErrorModel("An unknown error occurred");
    }
  }
}