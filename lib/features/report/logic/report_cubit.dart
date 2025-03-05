import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/helper/token.dart';
import 'package:graduation_project/features/report/data/models/report_data.dart';
import 'package:graduation_project/features/report/data/models/report_request.dart';
import 'package:graduation_project/features/report/data/repo/report_repo.dart';
import 'package:meta/meta.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportRepo reportRepo;
  final ReportData reportData = ReportData();

  ReportCubit(this.reportRepo) : super(ReportInitial());

  // تحديث نوع الحيوان
  void updateAnimalType(String? animalType) {
    reportData.animalType = animalType;
    log("Animal type updated: $animalType");
  }

  // تحديث الأمراض
  void updateDiseases(Map<String, bool> selectedMain,
      Map<String, Map<String, bool>> selectedSub) {
    reportData.insectRelatedIssues = _getSelectedDiseases(
        selectedMain, selectedSub, "الأمراض الناتجة عن لدغات الحشرات");
    reportData.bacterialIssues =
        _getSelectedDiseases(selectedMain, selectedSub, "الأمراض البكتيرية");
    reportData.viralIssues =
        _getSelectedDiseases(selectedMain, selectedSub, "الأمراض الفيروسية");
    reportData.infectionsAndParasites =
        _getSelectedDiseases(selectedMain, selectedSub, "الأمراض الطفيلية");
    reportData.newIssues =
        _getSelectedDiseases(selectedMain, selectedSub, "غير متأكد");
    reportData.respiratoryIssues =
        _getSelectedDiseases(selectedMain, selectedSub, "الأمراض التنفسية");
    reportData.traumasAndInheritance =
        _getSelectedDiseases(selectedMain, selectedSub, "التورمات والأورام");
    reportData.notDetermined =
        _getSelectedDiseases(selectedMain, selectedSub, "غير متأكد");
    log("Diseases updated: $reportData");
  }

  // تحديث الأسئلة التشخيصية
  void updateDiagnosticQuestions(Map<String, String?> answers) {
    reportData.naturalBehavior = answers["الحيوان بياكل طبيعي؟"];
    reportData.drinksWater = answers["الحيوان بيشرب مياه كفاية؟"];
    reportData.movesNormally = answers["الحيوان بيتحرك زي ما تعودت عليه؟"];
    reportData.breathingNormally = answers["بيتنفس طبيعي؟"];
    reportData.regularExcretion = answers["الإخراج منتظم؟"];
    reportData.hairLossOrSkinIssues =
        answers["فيه تساقط شعر أو بقع على الجلد؟"];
    reportData.previousSimilarSymptoms =
        answers["الحيوان كان تعرض لنفس الأعراض دي قبل كده؟"];
    reportData.vaccinationsUpToDate = answers["الحيوان خد تطعيماته كاملة؟"];
    reportData.recentBehaviorChange =
        answers["فيه أي تغيير في مكان الحيوان، أو أكله مؤخرًا؟"];
    log("Diagnostic questions updated: $reportData");
  }

  // تحديث الصور
  void updateImages(List<String> images) {
    reportData.based64 = images;
    log("Images updated: ${images.length} images");
  }

  // تحديث النوتس
  void updateNotes(String notes) {
    reportData.notes = notes;
    log("Notes updated: $notes");
  }

  //  معلومات صاحب البهيمة
  void updateContactInformation(String name, String phone, String address) {
    reportData.responsiblePersonName = name;
    reportData.responsiblePersonPhone = phone;
    reportData.caseAddress = address;
    log("Contact information updated: Name = $name, Phone = $phone, Address = $address");
  }

  // تحديث الموقع
  void updateLocation(double latitude, double longitude) {
    reportData.latitude = latitude;
    reportData.longitude = longitude;
    log("Location updated: Latitude = $latitude, Longitude = $longitude");
  }

  Future<void> submitReport() async {
    emit(ReportLoading());
    try {
      final requestModel = ReportRequest(
        animalType: reportData.animalType,
        originDetermination: OriginDetermination(
          insectRelatedIssues: reportData.insectRelatedIssues,
          bacterialIssues: reportData.bacterialIssues,
          viralIssues: reportData.viralIssues,
          infectionsAndParasites: reportData.infectionsAndParasites,
          newIssues: reportData.newIssues,
          respiratoryIssues: reportData.respiratoryIssues,
          traumasAndInheritance: reportData.traumasAndInheritance,
          notDetermined: reportData.notDetermined,
        ),
        diagnosticQuestions: DiagnosticQuestions(
          naturalBehavior: reportData.naturalBehavior ?? "غير متأكد",
          drinksWater: reportData.drinksWater ?? "غير متأكد",
          movesNormally: reportData.movesNormally ?? "غير متأكد",
          breathingNormally: reportData.breathingNormally ?? "غير متأكد",
          regularExcretion: reportData.regularExcretion ?? "غير متأكد",
          hairLossOrSkinIssues: reportData.hairLossOrSkinIssues ?? "غير متأكد",
          previousSimilarSymptoms:
              reportData.previousSimilarSymptoms ?? "غير متأكد",
          vaccinationsUpToDate: reportData.vaccinationsUpToDate ?? "غير متأكد",
          recentBehaviorChange: reportData.recentBehaviorChange ?? "غير متأكد",
        ),
        contactInformation: ContactInformation(
          responsiblePersonName: reportData.responsiblePersonName,
          responsiblePersonPhone: reportData.responsiblePersonPhone,
          caseAddress: reportData.caseAddress,
          caseLocation: CaseLocation(
            type: "Point",
            coordinates: [
              reportData.latitude ?? 0.0,
              reportData.longitude ?? 0.0,
            ],
          ),
        ),
        images: reportData.based64,
        notes: reportData.notes,
      );

      final TokenManager tokenManager = TokenManager();
      String? token = await tokenManager.getToken();

      final response = await reportRepo.report(token!, requestModel);
      emit(ReportSuccess());
    } catch (e) {
      emit(ReportFailure(errorMessage: "Failed to submit report: $e"));
    }
  }

  // لتحويل الأمراض المختارة إلى نص
  String? _getSelectedDiseases(Map<String, bool> selectedMain,
      Map<String, Map<String, bool>> selectedSub, String category) {
    if (selectedMain[category] == true) {
      return selectedSub[category]
          ?.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .join(", ");
    }
    return "غير متأكد";
  }
}
