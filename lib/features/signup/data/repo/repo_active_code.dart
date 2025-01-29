import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_request_activation_code.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_response_activation_code.dart';

class ActivateAccountRepository {
  final ApiService _apiService;

  ActivateAccountRepository(this._apiService);

  Future<ActivateAccountResponseModel> activateAccount(
      String email, String activationCode) async {
    try {
      final request = ActivateAccountRequestModel(
          email: email, activationCode: activationCode);
      final response = await _apiService.activateAccount(request);
      return response;
    } catch (e) {
      throw Exception('Failed to activate account: $e');
    }
  }
}
