import 'package:json_annotation/json_annotation.dart';

part 'report_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportRequest {
  final String? animalType;
  final OriginDetermination? originDetermination;
  final DiagnosticQuestions? diagnosticQuestions;
  final ContactInformation? contactInformation;
  final List<Images>? images;
  final String? notes;

  ReportRequest({
    this.animalType,
    this.originDetermination,
    this.diagnosticQuestions,
    this.contactInformation,
    this.images,
    this.notes,
  });

  factory ReportRequest.fromJson(Map<String, dynamic> json) => _$ReportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReportRequestToJson(this);
}

@JsonSerializable()
class OriginDetermination {
  final String? insectRelatedIssues;
  final String? bacterialIssues;
  final String? viralIssues;
  final String? infectionsAndParasites;
  final String? newIssues;
  final String? respiratoryIssues;
  final String? traumasAndInheritance;
  final String? notDetermined;

  OriginDetermination({
    this.insectRelatedIssues,
    this.bacterialIssues,
    this.viralIssues,
    this.infectionsAndParasites,
    this.newIssues,
    this.respiratoryIssues,
    this.traumasAndInheritance,
    this.notDetermined,
  });

  factory OriginDetermination.fromJson(Map<String, dynamic> json) => _$OriginDeterminationFromJson(json);
  Map<String, dynamic> toJson() => _$OriginDeterminationToJson(this);
}

@JsonSerializable()
class DiagnosticQuestions {
  final String? naturalBehavior;
  final String? drinksWater;
  final String? movesNormally;
  final String? breathingNormally;
  final String? regularExcretion;
  final String? hairLossOrSkinIssues;
  final String? previousSimilarSymptoms;
  final String? vaccinationsUpToDate;
  final String? recentBehaviorChange;

  DiagnosticQuestions({
    this.naturalBehavior,
    this.drinksWater,
    this.movesNormally,
    this.breathingNormally,
    this.regularExcretion,
    this.hairLossOrSkinIssues,
    this.previousSimilarSymptoms,
    this.vaccinationsUpToDate,
    this.recentBehaviorChange,
  });

  factory DiagnosticQuestions.fromJson(Map<String, dynamic> json) => _$DiagnosticQuestionsFromJson(json);
  Map<String, dynamic> toJson() => _$DiagnosticQuestionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContactInformation {
  final String? responsiblePersonName;
  final String? responsiblePersonPhone;
  final String? caseAddress;
  final CaseLocation? caseLocation;

  ContactInformation({
    this.responsiblePersonName,
    this.responsiblePersonPhone,
    this.caseAddress,
    this.caseLocation,
  });

  factory ContactInformation.fromJson(Map<String, dynamic> json) => _$ContactInformationFromJson(json);
  Map<String, dynamic> toJson() => _$ContactInformationToJson(this);
}

@JsonSerializable()
class CaseLocation {
  final String? type;
  final List<double>? coordinates;

  CaseLocation({this.type, this.coordinates});

  factory CaseLocation.fromJson(Map<String, dynamic> json) => _$CaseLocationFromJson(json);
  Map<String, dynamic> toJson() => _$CaseLocationToJson(this);
}

@JsonSerializable()
class Images {
  final String? based64;

  Images({this.based64});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
