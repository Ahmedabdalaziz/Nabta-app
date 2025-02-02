import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_error_model.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_request_model.dart';

class SendForgetPasswordRepo {
  final ApiService apiService;

  SendForgetPasswordRepo(this.apiService);

  Future<dynamic> sendEmailToForgetPass(String email) async {
    final requestModel = SendForgetPasswordRequestModel(email: email);
    try {
      final response = await apiService.sendForgetPasswordCode(requestModel);
      return response;
    } catch (e) {
      log("Error during forgetPassword: $e");
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          return SendForgetPasswordErrorModel.fromJson(response.data);
        } else {
          return SendForgetPasswordErrorModel("An unknown error occurred");
        }
      }
      return null;
    }
  }
}
