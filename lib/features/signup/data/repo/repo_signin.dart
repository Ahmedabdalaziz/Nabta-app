import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_response.dart';

class SignupRepository {
  final ApiService apiService;

  SignupRepository(this.apiService);

  Future<SignInResponseModel> signUp(Map<String, dynamic> body) async {
    try {
      final response = await apiService.signUp(body);
      return response;
    } catch (e) {
      throw Exception("Error during sign-up: ${e.toString()}");
    }
  }
}
