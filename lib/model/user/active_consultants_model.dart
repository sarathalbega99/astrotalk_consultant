class ActiveConsultantsModel {
  List<Consultants>? consultants;
  Pagination? pagination;

  ActiveConsultantsModel({this.consultants, this.pagination});

  ActiveConsultantsModel.fromJson(Map<String, dynamic> json) {
    if (json['consultants'] != null) {
      consultants = <Consultants>[];
      json['consultants'].forEach((v) {
        consultants!.add(Consultants.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (consultants != null) {
      data['consultants'] = consultants!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Consultants {
  String? userId;
  String? name;
  String? userPresence;
  int? rating;
  String? bioStatus;
  String? userStatus;
  bool? isFavourite;
  List<Languages>? languages;
  dynamic topics;
  String? lastActive;

  Consultants(
      {this.userId,
      this.name,
      this.userPresence,
      this.rating,
      this.bioStatus,
      this.userStatus,
      this.isFavourite,
      this.languages,
      this.topics,
      this.lastActive});

  Consultants.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    userPresence = json['user_presence'];
    rating = json['rating'];
    bioStatus = json['bio_status'];
    userStatus = json['user_status'];
    isFavourite = json['is_favourite'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <Null>[];
      // json['topics'].forEach((v) {
      //   topics!.add(Null.fromJson(v));
      // });
    }
    lastActive = json['last_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['user_presence'] = userPresence;
    data['rating'] = rating;
    data['bio_status'] = bioStatus;
    data['user_status'] = userStatus;
    data['is_favourite'] = isFavourite;
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    if (topics != null) {
      data['topics'] = topics!.map((v) => v?.toJson()).toList();
    }
    data['last_active'] = lastActive;
    return data;
  }
}

class Languages {
  String? languageId;
  String? languageName;
  String? languageIcon;
  String? shortCode;

  Languages(
      {this.languageId, this.languageName, this.languageIcon, this.shortCode});

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

class Pagination {
  int? total;
  int? page;
  int? perPage;
  int? totalPages;

  Pagination({this.total, this.page, this.perPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['per_page'] = perPage;
    data['total_pages'] = totalPages;
    return data;
  }
}
