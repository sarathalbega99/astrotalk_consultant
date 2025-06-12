class PiesocketTokenModel {
  bool? success;
  Data? data;

  PiesocketTokenModel({this.success, this.data});

  PiesocketTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? roomId;
  String? clusterId;
  String? apiKey;
  String? websocketHost;
  String? version;
  int? expiresIn;

  Data(
      {this.token,
      this.roomId,
      this.clusterId,
      this.apiKey,
      this.websocketHost,
      this.version,
      this.expiresIn});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    roomId = json['roomId'];
    clusterId = json['clusterId'];
    apiKey = json['apiKey'];
    websocketHost = json['websocketHost'];
    version = json['version'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['roomId'] = roomId;
    data['clusterId'] = clusterId;
    data['apiKey'] = apiKey;
    data['websocketHost'] = websocketHost;
    data['version'] = version;
    data['expiresIn'] = expiresIn;
    return data;
  }
}
