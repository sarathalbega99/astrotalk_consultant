class NotificationModel {
  List<Notifications>? notifications;
  int? unreadCount;
  Pagination? pagination;

  NotificationModel({this.notifications, this.unreadCount, this.pagination});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
    unreadCount = json['unread_count'];
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    data['unread_count'] = unreadCount;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? title;
  String? message;
  String? image;
  String? link;
  bool? isRead;
  String? createdAt;

  Notifications({
    this.id,
    this.title,
    this.message,
    this.image,
    this.link,
    this.isRead,
    this.createdAt,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
    link = json['link'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['image'] = image;
    data['link'] = link;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    return data;
  }
}

class Pagination {
  int? total;
  int? page;
  int? pages;

  Pagination({this.total, this.page, this.pages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['pages'] = pages;
    return data;
  }
}
