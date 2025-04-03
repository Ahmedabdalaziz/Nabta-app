import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/home/data/remot/model/user_data_request.dart';

class UserDataRepo {
  ApiService apiService;

  UserDataRepo(this.apiService);

  Future<UserDataResponse> getUserData(String token) async {
    try {
      final userData = await apiService.getUserData('bearer $token');
      return userData;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }
}
