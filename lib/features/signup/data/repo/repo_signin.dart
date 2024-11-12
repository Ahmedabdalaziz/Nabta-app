import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_error.dart';

class SignupRepository {
  final ApiService apiService;

  // استخدام ApiService الذي يتم الحصول عليه من GetIt
  SignupRepository(this.apiService);

  Future<dynamic> signUp(Map<String, dynamic> body) async {
    try {
      // إرسال الطلب عبر ApiService
      final response = await apiService.signUp(body);
      return response;
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
