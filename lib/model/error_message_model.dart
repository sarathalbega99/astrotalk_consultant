class ErrorMessageModel {
  String? errorMessage;

  ErrorMessageModel({this.errorMessage});

  ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorMessage'] = errorMessage;
    return data;
  }
}