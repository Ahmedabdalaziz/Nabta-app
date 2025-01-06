import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/core/widgets/token.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_error.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_response.dart';

class SignupRepository {
  final ApiService apiService;

  SignupRepository(this.apiService);

  Future<dynamic> signUp(Map<String, dynamic> body) async {
    try {
      final response = await apiService.signUp(body);
      final token = SignInResponseModel.fromJson(response as Map<String, dynamic>).token;

      // حفظ الـ token
      await TokenManager().saveToken(token);

      return token;
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          return SignUpErrorModel.fromJson(response.data);
        }
      }
      return SignUpErrorModel("An unknown error occurred");
    }
  }
}