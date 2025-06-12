class AppEndpoints {
  static const loginEndpoint = '/auth/authenticate';

  static const getProfileEndPoint = '/auth/user-profile';
  static const getNotificatonendPoint = '/notifications/list?page=1&limit=20';
  static const getPayoutsEndPoint = '/consultants/payouts';

  static const getActiveConsultantEndpoint = '/consultants/active-consultants';

  static const startCallEndpoint = '/calls/start-call';
  static const callHistoryEndpoint = '/calls/history';

  static const joinCallEndpoint = '/calls/join-call';
  static const endCallEndpoint = '/calls/end-call';

  static const rejectCallEndpoint = '/calls/reject-call';

  static const metaDataEndPoint = '/masters/brand-meta';

  static const pieSocketTokenEndpoint = '/piesocket/token?roomId=call_';
}
