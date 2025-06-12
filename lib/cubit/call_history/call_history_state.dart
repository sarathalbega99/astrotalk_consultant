part of 'call_history_cubit.dart';

@immutable
sealed class CallHistoryState {}

final class CallHistoryInitial extends CallHistoryState {}

final class CallHistoryLoading extends CallHistoryState {}

final class CallHistorySuccess extends CallHistoryState {
  final CallHistoryModel? callHistoryModel;
  CallHistorySuccess({required this.callHistoryModel});
}

final class CallHistoryFailed extends CallHistoryState {
  final String? failedMessage;
  CallHistoryFailed({required this.failedMessage});
}

final class CallHistoryError extends CallHistoryState {
  final String? errorMessage;
  CallHistoryError({required this.errorMessage});
}
