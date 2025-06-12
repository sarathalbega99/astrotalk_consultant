part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final NotificationModel? notificationModel;
  NotificationSuccess({required this.notificationModel});
}

final class NotificationFailed extends NotificationState {
  final String? failedMessage;
  NotificationFailed({required this.failedMessage});
}

final class NotificationError extends NotificationState {
  final String? errorMessage;
  NotificationError({required this.errorMessage});
}
