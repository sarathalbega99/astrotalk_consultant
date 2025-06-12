class EndCallModel {
  String? message;
  int? duration;
  int? coinsSpentOnCall;
  int? coinsSpentOnReactions;
  int? totalCoinsSpent;
  String? status;
  String? endReason;
  int? totalReactions;
  int? earningsFromCall;
  int? earningsFromReactions;
  int? totalEarnings;
  int? userBalance;

  EndCallModel(
      {this.message,
      this.duration,
      this.coinsSpentOnCall,
      this.coinsSpentOnReactions,
      this.totalCoinsSpent,
      this.status,
      this.endReason,
      this.totalReactions,
      this.earningsFromCall,
      this.earningsFromReactions,
      this.totalEarnings,
      this.userBalance});

  EndCallModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    duration = json['duration'];
    coinsSpentOnCall = json['coinsSpentOnCall'];
    coinsSpentOnReactions = json['coinsSpentOnReactions'];
    totalCoinsSpent = json['totalCoinsSpent'];
    status = json['status'];
    endReason = json['endReason'];
    totalReactions = json['totalReactions'];
    earningsFromCall = json['earningsFromCall'];
    earningsFromReactions = json['earningsFromReactions'];
    totalEarnings = json['totalEarnings'];
    userBalance = json['userBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['duration'] = duration;
    data['coinsSpentOnCall'] = coinsSpentOnCall;
    data['coinsSpentOnReactions'] = coinsSpentOnReactions;
    data['totalCoinsSpent'] = totalCoinsSpent;
    data['status'] = status;
    data['endReason'] = endReason;
    data['totalReactions'] = totalReactions;
    data['earningsFromCall'] = earningsFromCall;
    data['earningsFromReactions'] = earningsFromReactions;
    data['totalEarnings'] = totalEarnings;
    data['userBalance'] = userBalance;
    return data;
  }
}
