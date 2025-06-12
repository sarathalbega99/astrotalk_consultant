part of 'call_cubit.dart';

@immutable
sealed class CallState {}

final class CallInitial extends CallState {}
final class JoinCallLoading extends CallState {}

final class JoinCallSuccess extends CallState {
  final JoinCallModel? joinCallModel;
  JoinCallSuccess({required this.joinCallModel});
}

final class JoinCallFailed extends CallState {
  final String? failedMessage;
  JoinCallFailed({required this.failedMessage});
}

final class JoinCallError extends CallState {
  final String? errorMessage;
  JoinCallError({required this.errorMessage});
}

final class EndCallLoading extends CallState {}

final class EndCallSuccess extends CallState {
  final EndCallModel? endCallModel;
  EndCallSuccess({required this.endCallModel});
}

final class EndCallFailed extends CallState {
  final String? failedMessage;
  EndCallFailed({required this.failedMessage});
}

final class EndCallError extends CallState {
  final String? errorMessage;
  EndCallError({required this.errorMessage});
}
