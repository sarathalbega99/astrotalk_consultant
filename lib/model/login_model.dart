class LoginModel {
  dynamic accessToken;
  dynamic tokenType;
  dynamic userId;
  dynamic isConsultant;
  dynamic userStatus;
  dynamic onboardingStatus;
  DeviceInfo? deviceInfo;

  LoginModel(
      {this.accessToken,
      this.tokenType,
      this.userId,
      this.isConsultant,
      this.userStatus,
      this.onboardingStatus,
      this.deviceInfo});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    userId = json['user_id'];
    isConsultant = json['is_consultant'];
    userStatus = json['user_status'];
    onboardingStatus = json['onboarding_status'];
    deviceInfo = json['device_info'] != null
        ? DeviceInfo.fromJson(json['device_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['user_id'] = userId;
    data['is_consultant'] = isConsultant;
    data['user_status'] = userStatus;
    data['onboarding_status'] = onboardingStatus;
    if (deviceInfo != null) {
      data['device_info'] = deviceInfo!.toJson();
    }
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

  DeviceInfo(
      {this.deviceId,
      this.deviceType,
      this.deviceOs,
      this.deviceModel,
      this.osVersion,
      this.appVersion,
      this.notificationEnabled,
      this.isPhysicalDevice,
      this.isLowRamDevice});

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
