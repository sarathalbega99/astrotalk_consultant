class UserProfileModel {
  User? user;
  Realtime? realtime;

  UserProfileModel({this.user, this.realtime});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    realtime =
        json['realtime'] != null ? Realtime.fromJson(json['realtime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (realtime != null) {
      data['realtime'] = realtime!.toJson();
    }
    return data;
  }
}

class User {
  dynamic userId;
  dynamic name;
  dynamic mobileNumber;
  dynamic gender;
  dynamic dateOfBirth;
  dynamic userStatus;
  dynamic userPresence;
  dynamic onboardingStatus;
  dynamic lastLoginAt;
  dynamic lastActiveAt;
  dynamic isConsultant;
  dynamic consultantRating;
  dynamic userRating;
  dynamic coinsBalance;
  dynamic currentEarnings;
  dynamic totalEarned;
  Bio? bio;
  DeviceInfo? deviceInfo;
  dynamic referralCode;
  dynamic referredBy;
  dynamic bankDetails;
  List<Languages>? languages;
  List<Topics>? topics;

  User({
    this.userId,
    this.name,
    this.mobileNumber,
    this.gender,
    this.dateOfBirth,
    this.userStatus,
    this.userPresence,
    this.onboardingStatus,
    this.lastLoginAt,
    this.lastActiveAt,
    this.isConsultant,
    this.consultantRating,
    this.userRating,
    this.coinsBalance,
    this.currentEarnings,
    this.totalEarned,
    this.bio,
    this.deviceInfo,
    this.referralCode,
    this.referredBy,
    this.bankDetails,
    this.languages,
    this.topics,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    userStatus = json['user_status'];
    userPresence = json['user_presence'];
    onboardingStatus = json['onboarding_status'];
    lastLoginAt = json['last_login_at'];
    lastActiveAt = json['last_active_at'];
    isConsultant = json['is_consultant'];
    consultantRating = json['consultant_rating'];
    userRating = json['user_rating'];
    coinsBalance = json['coins_balance'];
    currentEarnings = json['current_earnings'];
    totalEarned = json['total_earned'];
    bio = json['bio'] != null ? Bio.fromJson(json['bio']) : null;
    deviceInfo =
        json['device_info'] != null
            ? DeviceInfo.fromJson(json['device_info'])
            : null;
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    bankDetails = json['bank_details'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['user_status'] = userStatus;
    data['user_presence'] = userPresence;
    data['onboarding_status'] = onboardingStatus;
    data['last_login_at'] = lastLoginAt;
    data['last_active_at'] = lastActiveAt;
    data['is_consultant'] = isConsultant;
    data['consultant_rating'] = consultantRating;
    data['user_rating'] = userRating;
    data['coins_balance'] = coinsBalance;
    data['current_earnings'] = currentEarnings;
    data['total_earned'] = totalEarned;
    if (bio != null) {
      data['bio'] = bio!.toJson();
    }
    if (deviceInfo != null) {
      data['device_info'] = deviceInfo!.toJson();
    }
    data['referral_code'] = referralCode;
    data['referred_by'] = referredBy;
    data['bank_details'] = bankDetails;
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bio {
  dynamic status;

  Bio({this.status});

  Bio.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class DeviceInfo {
  dynamic deviceId;
  dynamic deviceType;
  dynamic deviceOs;
  dynamic deviceModel;
  dynamic osVersion;
  dynamic appVersion;
  dynamic notificationEnabled;
  dynamic isPhysicalDevice;
  dynamic isLowRamDevice;

  DeviceInfo({
    this.deviceId,
    this.deviceType,
    this.deviceOs,
    this.deviceModel,
    this.osVersion,
    this.appVersion,
    this.notificationEnabled,
    this.isPhysicalDevice,
    this.isLowRamDevice,
  });

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    deviceOs = json['device_os'];
    deviceModel = json['device_model'];
    osVersion = json['os_version'];
    appVersion = json['app_version'];
    notificationEnabled = json['notification_enabled'];
    isPhysicalDevice = json['is_physical_device'];
    isLowRamDevice = json['is_low_ram_device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['device_os'] = deviceOs;
    data['device_model'] = deviceModel;
    data['os_version'] = osVersion;
    data['app_version'] = appVersion;
    data['notification_enabled'] = notificationEnabled;
    data['is_physical_device'] = isPhysicalDevice;
    data['is_low_ram_device'] = isLowRamDevice;
    return data;
  }
}

class Languages {
  dynamic languageId;
  dynamic languageName;
  dynamic languageIcon;
  dynamic shortCode;

  Languages({
    this.languageId,
    this.languageName,
    this.languageIcon,
    this.shortCode,
  });

  Languages.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    languageName = json['language_name'];
    languageIcon = json['language_icon'];
    shortCode = json['short_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language_id'] = languageId;
    data['language_name'] = languageName;
    data['language_icon'] = languageIcon;
    data['short_code'] = shortCode;
    return data;
  }
}

class Topics {
  dynamic topicId;
  dynamic topicName;
  dynamic topicIcon;
  dynamic isParent;
  dynamic parentTopicId;

  Topics({
    this.topicId,
    this.topicName,
    this.topicIcon,
    this.isParent,
    this.parentTopicId,
  });

  Topics.fromJson(Map<String, dynamic> json) {
    topicId = json['topic_id'];
    topicName = json['topic_name'];
    topicIcon = json['topic_icon'];
    isParent = json['is_parent'];
    parentTopicId = json['parent_topic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topic_id'] = topicId;
    data['topic_name'] = topicName;
    data['topic_icon'] = topicIcon;
    data['is_parent'] = isParent;
    data['parent_topic_id'] = parentTopicId;
    return data;
  }
}

class Realtime {
  dynamic token;
  dynamic clusterId;
  dynamic apiKey;
  dynamic websocketHost;
  dynamic version;

  Realtime({
    this.token,
    this.clusterId,
    this.apiKey,
    this.websocketHost,
    this.version,
  });

  Realtime.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    clusterId = json['clusterId'];
    apiKey = json['apiKey'];
    websocketHost = json['websocketHost'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['clusterId'] = clusterId;
    data['apiKey'] = apiKey;
    data['websocketHost'] = websocketHost;
    data['version'] = version;
    return data;
  }
}
