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

  void updateAnimalType(String animalType) {
    reportData.animalType = animalType;
    log("Updated animal type: $animalType");
  }

  void updateOriginDetermination(OriginDetermination originDetermination) {
    reportData.insectRelatedIssues = originDetermination.insectRelatedIssues;
    reportData.bacterialIssues = originDetermination.bacterialIssues;
    reportData.viralIssues = originDetermination.viralIssues;
    reportData.infectionsAndParasites =
        originDetermination.infectionsAndParasites;
    reportData.newIssues = originDetermination.newIssues;
    reportData.respiratoryIssues = originDetermination.respiratoryIssues;
    reportData.traumasAndInheritance =
        originDetermination.traumasAndInheritance;
    reportData.notDetermined = originDetermination.notDetermined;
    log("Updated origin determination: $originDetermination");
  }

  void updateDiagnosticQuestions(DiagnosticQuestions diagnosticQuestions) {
    reportData.naturalBehavior = diagnosticQuestions.naturalBehavior;
    reportData.drinksWater = diagnosticQuestions.drinksWater;
    reportData.movesNormally = diagnosticQuestions.movesNormally;
    reportData.breathingNormally = diagnosticQuestions.breathingNormally;
    reportData.regularExcretion = diagnosticQuestions.regularExcretion;
    reportData.hairLossOrSkinIssues = diagnosticQuestions.hairLossOrSkinIssues;
    reportData.previousSimilarSymptoms =
        diagnosticQuestions.previousSimilarSymptoms;
    reportData.vaccinationsUpToDate = diagnosticQuestions.vaccinationsUpToDate;
    reportData.recentBehaviorChange = diagnosticQuestions.recentBehaviorChange;
    log("Updated diagnostic questions: $diagnosticQuestions");
  }

  void updateContactInformation(ContactInformation contactInformation) {
    reportData.responsiblePersonName = contactInformation.responsiblePersonName;
    reportData.responsiblePersonPhone =
        contactInformation.responsiblePersonPhone;
    reportData.caseAddress = contactInformation.caseAddress;
    reportData.latitude = contactInformation.caseLocation?.coordinates?[0];
    reportData.longitude = contactInformation.caseLocation?.coordinates?[1];
    log("Updated contact information: $contactInformation");
  }

  void updateImages(List<String> images) {
    reportData.based64 = images;
    log("Updated images: ${images.length} images added");
  }

  void updateNotes(String notes) {
    reportData.notes = notes;
    log("Updated notes: $notes");
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
          naturalBehavior: reportData.naturalBehavior,
          drinksWater: reportData.drinksWater,
          movesNormally: reportData.movesNormally,
          breathingNormally: reportData.breathingNormally,
          regularExcretion: reportData.regularExcretion,
          hairLossOrSkinIssues: reportData.hairLossOrSkinIssues,
          previousSimilarSymptoms: reportData.previousSimilarSymptoms,
          vaccinationsUpToDate: reportData.vaccinationsUpToDate,
          recentBehaviorChange: reportData.recentBehaviorChange,
        ),
        contactInformation: ContactInformation(
          responsiblePersonName: reportData.responsiblePersonName,
          responsiblePersonPhone: reportData.responsiblePersonPhone,
          caseAddress: reportData.caseAddress,
          caseLocation: CaseLocation(
            type: "Point",
            coordinates: [
              reportData.latitude ?? 0.0,
              reportData.longitude ?? 0.0
            ],
          ),
        ),
        images: reportData.based64?.map((e) => Images(based64: e)).toList(),
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
}
