class MetaDataModel {
  BrandMeta? brandMeta;

  MetaDataModel({this.brandMeta});

  MetaDataModel.fromJson(Map<String, dynamic> json) {
    brandMeta = json['brand_meta'] != null
        ? BrandMeta.fromJson(json['brand_meta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brandMeta != null) {
      data['brand_meta'] = brandMeta!.toJson();
    }
    return data;
  }
}

class BrandMeta {
  String? brandName;
  String? brandLogo;
  String? brandIcon;
  String? privacyPolicy;
  String? termsAndConditions;
  String? refundPolicy;
  String? supportLink;
  int? callTimeout;
  int? chargePerSecond;
  String? razorpayKey;
  String? defaultPaymentGateway;
  int? minimumBalance;
  String? piesocketClusterId;
  String? piesocketApiKey;
  List<DefaultLanguages>? defaultLanguages;

  BrandMeta(
      {this.brandName,
      this.brandLogo,
      this.brandIcon,
      this.privacyPolicy,
      this.termsAndConditions,
      this.refundPolicy,
      this.supportLink,
      this.callTimeout,
      this.chargePerSecond,
      this.razorpayKey,
      this.defaultPaymentGateway,
      this.minimumBalance,
      this.piesocketClusterId,
      this.piesocketApiKey,
      this.defaultLanguages});

  BrandMeta.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    brandLogo = json['brand_logo'];
    brandIcon = json['brand_icon'];
    privacyPolicy = json['privacy_policy'];
    termsAndConditions = json['terms_and_conditions'];
    refundPolicy = json['refund_policy'];
    supportLink = json['support_link'];
    callTimeout = json['call_timeout'];
    chargePerSecond = json['charge_per_second'];
    razorpayKey = json['razorpay_key'];
    defaultPaymentGateway = json['default_payment_gateway'];
    minimumBalance = json['minimum_balance'];
    piesocketClusterId = json['piesocket_cluster_id'];
    piesocketApiKey = json['piesocket_api_key'];
    if (json['default_languages'] != null) {
      defaultLanguages = <DefaultLanguages>[];
      json['default_languages'].forEach((v) {
        defaultLanguages!.add(DefaultLanguages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_name'] = brandName;
    data['brand_logo'] = brandLogo;
    data['brand_icon'] = brandIcon;
    data['privacy_policy'] = privacyPolicy;
    data['terms_and_conditions'] = termsAndConditions;
    data['refund_policy'] = refundPolicy;
    data['support_link'] = supportLink;
    data['call_timeout'] = callTimeout;
    data['charge_per_second'] = chargePerSecond;
    data['razorpay_key'] = razorpayKey;
    data['default_payment_gateway'] = defaultPaymentGateway;
    data['minimum_balance'] = minimumBalance;
    data['piesocket_cluster_id'] = piesocketClusterId;
    data['piesocket_api_key'] = piesocketApiKey;
    if (defaultLanguages != null) {
      data['default_languages'] =
          defaultLanguages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DefaultLanguages {
  String? languageId;
  String? languageName;
  String? languageText;
  String? languageIcon;
  String? shortCode;

  DefaultLanguages(
      {this.languageId,
      this.languageName,
      this.languageText,
      this.languageIcon,
      this.shortCode});

  DefaultLanguages.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    languageName = json['language_name'];
    languageText = json['language_text'];
    languageIcon = json['language_icon'];
    shortCode = json['short_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language_id'] = languageId;
    data['language_name'] = languageName;
    data['language_text'] = languageText;
    data['language_icon'] = languageIcon;
    data['short_code'] = shortCode;
    return data;
  }
}
