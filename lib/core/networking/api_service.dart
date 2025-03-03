import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_constants.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_request_model.dart';
import 'package:graduation_project/features/forget_password/data/model/send_code_response_model.dart';
import 'package:graduation_project/features/login/data/models/respons_login_model.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';
import 'package:graduation_project/features/signup/data/model/custom/sigin_model_response.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_request_activation_code.dart';
import 'package:graduation_project/features/signup/data/model/custom/sign_response_activation_code.dart'; // استيراد الموديل
import 'package:retrofit/retrofit.dart';

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

  //ابعت ايميل وكود
  @POST(ApiConstants.activateAccount)
  Future<ActivateAccountResponseModel> activateAccount(
      @Body() ActivateAccountRequestModel body);

  // هنبعت الكود علي الجيميل ياكوتش
  @POST(ApiConstants.sendForgetPasswordCode)
  Future<SendForgetPasswordResponseModel> sendForgetPasswordCode(
      @Body() SendForgetPasswordRequestModel body);

  @GET(ApiConstants.plantApi)
  Future<PlantResponse> getAllPlants(@Header('Authorization') String token);
}
