import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static const Duration timeOut = Duration(seconds: 10);
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options
        ..connectTimeout = timeOut
        ..receiveTimeout = timeOut;
      addDioInter();
    }
    return _dio!;
  }

  static void addDioInter() {
    _dio!.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
