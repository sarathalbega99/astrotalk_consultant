part of 'consultant_home_cubit.dart';

@immutable
sealed class ConsultantHomeState {}

final class ConsultantHomeInitial extends ConsultantHomeState {}

final class ConsultantHomeLoading extends ConsultantHomeState {}

final class ConsultantHomeSuccess extends ConsultantHomeState {
  final UserProfileModel? userProfileModel;
  ConsultantHomeSuccess({required this.userProfileModel});
}

final class ConsultantHomeFailed extends ConsultantHomeState {
  final String? failedMessage;
  ConsultantHomeFailed({required this.failedMessage});
}

final class ConsultantHomeError extends ConsultantHomeState {
  final String? errorMessage;
  ConsultantHomeError({required this.errorMessage});
}

final class MetaDataLoading extends ConsultantHomeState {}

final class MetaDataSuccess extends ConsultantHomeState {
  final MetaDataModel? metaDataModel;
  MetaDataSuccess({required this.metaDataModel});
}

final class MetaDataFailed extends ConsultantHomeState {
  final String? failedmessage;
  MetaDataFailed({required this.failedmessage});
}

final class MetaDataError extends ConsultantHomeState {
  final String? errorMessage;
  MetaDataError({required this.errorMessage});
}

final class PieSocketTokenLoading extends ConsultantHomeState {}

final class PieSocketTokenSuccess extends ConsultantHomeState {
  final PiesocketTokenModel? piesocketTokenModel;
  PieSocketTokenSuccess({required this.piesocketTokenModel});
}

final class PieSocketTokenFailed extends ConsultantHomeState {
  final String? failedMessage;
  PieSocketTokenFailed({required this.failedMessage});
}

final class PieSocketTokenError extends ConsultantHomeState {
  final String? errorMessage;
  PieSocketTokenError({required this.errorMessage});
}

final class RejectCallLoading extends ConsultantHomeState {}

final class RejectCallSuccess extends ConsultantHomeState {}

final class RejectCallFailed extends ConsultantHomeState {
  final String? failedMessage;
  RejectCallFailed({required this.failedMessage});
}

final class RejectCallError extends ConsultantHomeState {
  final String? errorMessage;
  RejectCallError({required this.errorMessage});
}
