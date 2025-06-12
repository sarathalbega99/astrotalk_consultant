class JoinCallModel {
  String? message;
  String? callId;
  String? meetingId;
  String? token;
  String? startedAt;
  int? chargePerMinute;
 
  JoinCallModel(
      {this.message,
      this.callId,
      this.meetingId,
      this.token,
      this.startedAt,
      this.chargePerMinute});
 
  JoinCallModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    callId = json['callId'];
    meetingId = json['meetingId'];
    token = json['token'];
    startedAt = json['startedAt'];
    chargePerMinute = json['chargePerMinute'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['callId'] = callId;
    data['meetingId'] = meetingId;
    data['token'] = token;
    data['startedAt'] = startedAt;
    data['chargePerMinute'] = chargePerMinute;
    return data;
  }
}