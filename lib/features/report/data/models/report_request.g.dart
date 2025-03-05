// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportRequest _$ReportRequestFromJson(Map<String, dynamic> json) =>
    ReportRequest(
      animalType: json['animalType'] as String?,
      originDetermination: json['originDetermination'] == null
          ? null
          : OriginDetermination.fromJson(
              json['originDetermination'] as Map<String, dynamic>),
      diagnosticQuestions: json['diagnosticQuestions'] == null
          ? null
          : DiagnosticQuestions.fromJson(
              json['diagnosticQuestions'] as Map<String, dynamic>),
      contactInformation: json['contactInformation'] == null
          ? null
          : ContactInformation.fromJson(
              json['contactInformation'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ReportRequestToJson(ReportRequest instance) =>
    <String, dynamic>{
      'animalType': instance.animalType,
      'originDetermination': instance.originDetermination?.toJson(),
      'diagnosticQuestions': instance.diagnosticQuestions?.toJson(),
      'contactInformation': instance.contactInformation?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
    };

OriginDetermination _$OriginDeterminationFromJson(Map<String, dynamic> json) =>
    OriginDetermination(
      insectRelatedIssues: json['insectRelatedIssues'] as String?,
      bacterialIssues: json['bacterialIssues'] as String?,
      viralIssues: json['viralIssues'] as String?,
      infectionsAndParasites: json['infectionsAndParasites'] as String?,
      newIssues: json['newIssues'] as String?,
      respiratoryIssues: json['respiratoryIssues'] as String?,
      traumasAndInheritance: json['traumasAndInheritance'] as String?,
      notDetermined: json['notDetermined'] as String?,
    );

Map<String, dynamic> _$OriginDeterminationToJson(
        OriginDetermination instance) =>
    <String, dynamic>{
      'insectRelatedIssues': instance.insectRelatedIssues,
      'bacterialIssues': instance.bacterialIssues,
      'viralIssues': instance.viralIssues,
      'infectionsAndParasites': instance.infectionsAndParasites,
      'newIssues': instance.newIssues,
      'respiratoryIssues': instance.respiratoryIssues,
      'traumasAndInheritance': instance.traumasAndInheritance,
      'notDetermined': instance.notDetermined,
    };

DiagnosticQuestions _$DiagnosticQuestionsFromJson(Map<String, dynamic> json) =>
    DiagnosticQuestions(
      naturalBehavior: json['naturalBehavior'] as String?,
      drinksWater: json['drinksWater'] as String?,
      movesNormally: json['movesNormally'] as String?,
      breathingNormally: json['breathingNormally'] as String?,
      regularExcretion: json['regularExcretion'] as String?,
      hairLossOrSkinIssues: json['hairLossOrSkinIssues'] as String?,
      previousSimilarSymptoms: json['previousSimilarSymptoms'] as String?,
      vaccinationsUpToDate: json['vaccinationsUpToDate'] as String?,
      recentBehaviorChange: json['recentBehaviorChange'] as String?,
    );

Map<String, dynamic> _$DiagnosticQuestionsToJson(
        DiagnosticQuestions instance) =>
    <String, dynamic>{
      'naturalBehavior': instance.naturalBehavior,
      'drinksWater': instance.drinksWater,
      'movesNormally': instance.movesNormally,
      'breathingNormally': instance.breathingNormally,
      'regularExcretion': instance.regularExcretion,
      'hairLossOrSkinIssues': instance.hairLossOrSkinIssues,
      'previousSimilarSymptoms': instance.previousSimilarSymptoms,
      'vaccinationsUpToDate': instance.vaccinationsUpToDate,
      'recentBehaviorChange': instance.recentBehaviorChange,
    };

ContactInformation _$ContactInformationFromJson(Map<String, dynamic> json) =>
    ContactInformation(
      responsiblePersonName: json['responsiblePersonName'] as String?,
      responsiblePersonPhone: json['responsiblePersonPhone'] as String?,
      caseAddress: json['caseAddress'] as String?,
      caseLocation: json['caseLocation'] == null
          ? null
          : CaseLocation.fromJson(json['caseLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactInformationToJson(ContactInformation instance) =>
    <String, dynamic>{
      'responsiblePersonName': instance.responsiblePersonName,
      'responsiblePersonPhone': instance.responsiblePersonPhone,
      'caseAddress': instance.caseAddress,
      'caseLocation': instance.caseLocation?.toJson(),
    };

CaseLocation _$CaseLocationFromJson(Map<String, dynamic> json) => CaseLocation(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$CaseLocationToJson(CaseLocation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      based64: json['based64'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'based64': instance.based64,
    };
