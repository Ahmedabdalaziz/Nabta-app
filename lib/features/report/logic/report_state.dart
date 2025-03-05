part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportSuccess extends ReportState {}

final class ReportFailure extends ReportState {
  final String errorMessage;

  ReportFailure({required this.errorMessage});
}

final class ReportLoading extends ReportState {}
