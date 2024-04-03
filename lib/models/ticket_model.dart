class TicketModel {
  TicketModel({
    this.id,
    this.userId,
    required this.title,
    this.ticketId,
    this.sentByUser,
    this.sentByAdmin,
    this.message,
    this.file,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
  });

  TicketModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'] ?? "";
    ticketId = json['ticket_id'];
    sentByUser = json['user'];
    sentByAdmin = json['admin'];
    message = json['message'];
    if(json['file'] != null) {
      file = json['file'];
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    closedAt = json['closed_at'];
  }
  int? id;
  int? userId;
  late String title;
  int? ticketId;
  int? sentByUser;
  int? sentByAdmin;
  String? message;
  String? file;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? closedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['title'] = title;
    map['ticket_id'] = ticketId;
    map['user'] = sentByUser;
    map['admin'] = sentByAdmin;
    map['message'] = message;
    map['file'] = file;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['closed_at'] = closedAt;
    return map;
  }
}