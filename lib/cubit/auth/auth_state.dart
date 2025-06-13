part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final LoginModel? loginModel;
  LoginSuccess({required this.loginModel});
}

final class LoginFailed extends AuthState {
  final String? failedMessage;
  LoginFailed({required this.failedMessage});
}

final class LoginError extends AuthState {
  final String? errorMessage;
  LoginError({required this.errorMessage});
}

final class OnboardLoading extends AuthState {}

final class OnboardSuccess extends AuthState {}

final class OnboardFailed extends AuthState {
  final String? failedMessage;
  OnboardFailed({required this.failedMessage});
}

final class OnboardError extends AuthState {
  final String? errorMessage;
  OnboardError({required this.errorMessage});
}

final class SendDeviceInfoLoading extends AuthState {}

final class SendDeviceInfoSuccess extends AuthState {}

final class SendDeviceInfoFailed extends AuthState {
  final String? failedMessage;
  SendDeviceInfoFailed({required this.failedMessage});
}

final class SendDeviceInfoError extends AuthState {
  final String? errorMessage;
  SendDeviceInfoError({required this.errorMessage});
}
