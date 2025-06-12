part of 'pay_out_cubit.dart';

@immutable
sealed class PayOutState {}

final class PayOutInitial extends PayOutState {}

final class PayOutLoading extends PayOutState {}

final class PayOutSuccess extends PayOutState {}

final class PayOutFailed extends PayOutState {
  final String? failedMessage;
  PayOutFailed({required this.failedMessage});
}

final class PayOutError extends PayOutState {
  final String? errorMessage;
  PayOutError({required this.errorMessage});
}
