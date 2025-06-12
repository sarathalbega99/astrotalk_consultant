class IcomingCallModel {
  String? callId;
  String? status;
  Consultant? consultant;
  Consultant? user;
  String? meetingId;
  String? token;
  String? callType;
  String? initiatedAt;

  IcomingCallModel(
      {this.callId,
      this.status,
      this.consultant,
      this.user,
      this.meetingId,
      this.token,
      this.callType,
      this.initiatedAt});

  IcomingCallModel.fromJson(Map<String, dynamic> json) {
    callId = json['call_id'];
    status = json['status'];
    consultant = json['consultant'] != null
        ? Consultant.fromJson(json['consultant'])
        : null;
    user = json['user'] != null ? Consultant.fromJson(json['user']) : null;
    meetingId = json['meetingId'];
    token = json['token'];
    callType = json['callType'];
    initiatedAt = json['initiatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_id'] = callId;
    data['status'] = status;
    if (consultant != null) {
      data['consultant'] = consultant!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['meetingId'] = meetingId;
    data['token'] = token;
    data['callType'] = callType;
    data['initiatedAt'] = initiatedAt;
    return data;
  }
}

class Consultant {
  String? id;
  String? name;

  Consultant({this.id, this.name});

  Consultant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
