import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/report/data/models/report_request.dart';
import 'package:graduation_project/features/report/data/models/report_response.dart';

class ReportRepo {
  final ApiService apiService;

  ReportRepo(this.apiService);

  Future<ReportResponseModel> report(
      String token, ReportRequest request) async {
    try {
      final requestModel = await apiService.report('bearer $token', request);
      return requestModel;
    } catch (e) {
      throw Exception('Failed to report: $e');
    }
  }
}
