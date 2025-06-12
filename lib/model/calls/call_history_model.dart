class CallHistoryModel {
  List<Calls>? calls;
  Pagination? pagination;

  CallHistoryModel({this.calls, this.pagination});

  CallHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['calls'] != null) {
      calls = <Calls>[];
      json['calls'].forEach((v) {
        calls!.add(Calls.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (calls != null) {
      data['calls'] = calls!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Calls {
  String? status;
  String? callId;
  int? duration;
  int? totalReactions;
  String? earningsFromCall;
  String? earningsFromReactions;
  String? consultantEarned;
  String? initiatedDate;
  User? user;
  User? consultant;
  dynamic reactions;

  Calls(
      {this.status,
      this.callId,
      this.duration,
      this.totalReactions,
      this.earningsFromCall,
      this.earningsFromReactions,
      this.consultantEarned,
      this.initiatedDate,
      this.user,
      this.consultant,
      this.reactions});

  Calls.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    callId = json['callId'];
    duration = json['duration'];
    totalReactions = json['totalReactions'];
    earningsFromCall = json['earningsFromCall'];
    earningsFromReactions = json['earningsFromReactions'];
    consultantEarned = json['consultantEarned'];
    initiatedDate = json['initiatedDate'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    consultant = json['consultant'] != null
        ? User.fromJson(json['consultant'])
        : null;
    // if (json['reactions'] != null) {
    //   reactions = <Null>[];
    //   json['reactions'].forEach((v) {
    //     reactions!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['callId'] = callId;
    data['duration'] = duration;
    data['totalReactions'] = totalReactions;
    data['earningsFromCall'] = earningsFromCall;
    data['earningsFromReactions'] = earningsFromReactions;
    data['consultantEarned'] = consultantEarned;
    data['initiatedDate'] = initiatedDate;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (consultant != null) {
      data['consultant'] = consultant!.toJson();
    }
    // if (reactions != null) {
    //   data['reactions'] = reactions!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class User {
  String? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? pages;

  Pagination({this.total, this.page, this.limit, this.pages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['pages'] = pages;
    return data;
  }
}
