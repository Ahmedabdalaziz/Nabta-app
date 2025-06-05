import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/signup/data/model/custom/email_check.dart';
import 'package:graduation_project/features/signup/data/model/custom/signup_models/sigin_model_response.dart';

class SignupRepository {
  final ApiService apiService;

  SignupRepository(this.apiService);

  Future<SignInResponseModel> signUp(Map<String, dynamic> body) async {
    try {
      final response = await apiService.signUp(body);
      return response;
    } catch (e) {
      throw Exception("Error during sign-up");
    }
  }

  Future<EmailCheckResponseModel> emailCheck(String email) async {
    try {
      final requestModel = EmailCheckRequestModel(email: email);
      final response = await apiService.checkEmail(requestModel);
      return response;
    } catch (e) {
      throw Exception("Error during email check");
    }
  }
}
