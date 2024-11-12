import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_constants.dart';
import 'package:graduation_project/features/login/data/models/respons_login_model.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:graduation_project/core/networking/dio_factory.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) {
    return _ApiService(dio);
  }

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.singUp)
  Future<SignInResponseModel> signUp(@Body() Map<String, dynamic> body);
}
