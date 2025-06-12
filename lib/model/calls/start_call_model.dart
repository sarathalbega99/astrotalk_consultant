class StartCallModel {
  dynamic message;
  dynamic callId;
  dynamic token;
  dynamic meetingId;
  dynamic status;
  Consultant? consultant;
  Balance? balance;

  StartCallModel(
      {this.message,
      this.callId,
      this.token,
      this.meetingId,
      this.status,
      this.consultant,
      this.balance});

  StartCallModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    callId = json['call_id'];
    token = json['token'];
    meetingId = json['meeting_id'];
    status = json['status'];
    consultant = json['consultant'] != null
        ? Consultant.fromJson(json['consultant'])
        : null;
    balance =
        json['balance'] != null ? Balance.fromJson(json['balance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['call_id'] = callId;
    data['token'] = token;
    data['meeting_id'] = meetingId;
    data['status'] = status;
    if (consultant != null) {
      data['consultant'] = consultant!.toJson();
    }
    if (balance != null) {
      data['balance'] = balance!.toJson();
    }
    return data;
  }
}

class Consultant {
  dynamic id;
  dynamic name;
  dynamic rating;

  Consultant({this.id, this.name, this.rating});

  Consultant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rating'] = rating;
    return data;
  }
}

class Balance {
  dynamic current;
  dynamic required;
  dynamic callDurationAvailable;

  Balance({this.current, this.required, this.callDurationAvailable});

  Balance.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    required = json['required'];
    callDurationAvailable = json['call_duration_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['required'] = required;
    data['call_duration_available'] = callDurationAvailable;
    return data;
  }
}
