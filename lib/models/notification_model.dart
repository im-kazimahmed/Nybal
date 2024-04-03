class NotificationModel {
  NotificationModel({
    this.id,
    this.userId,
    this.notificationTitle,
    this.notificationDescription,
    this.createdAt,
  });

  NotificationModel.fromJson(dynamic json) {
    id = json['id'] ;
    userId = json['user_id'];
    notificationTitle = json['notification_title'];
    notificationDescription = json['notification_description'];
    createdAt = json['created_at'];
  }
  int? id;
  int? userId;
  String? notificationTitle;
  String? notificationDescription;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['notification_title'] = notificationTitle;
    map['notification_description'] = notificationDescription;
    map['created_at'] = createdAt;
    return map;
  }
}