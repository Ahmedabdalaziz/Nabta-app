import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/login/data/models/request_login_model.dart';
import 'package:graduation_project/features/login/data/models/login_error_model.dart';

class LoginRepository {
  final ApiService apiService;

  LoginRepository(this.apiService);

  Future<dynamic> login(String email, String password) async {
    final requestModel = LoginRequestModel(email: email, password: password);
    try {
      return await apiService.login(requestModel.toJson());
    } catch (e) {
      log("Error during login: $e");
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          return LoginErrorModel.fromJson(response.data);
        } else {
          return LoginErrorModel("An unknown error occurred");
        }
      }
      return null;
    }
  }
}
