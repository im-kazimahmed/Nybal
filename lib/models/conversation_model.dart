import 'message_model.dart';

class ConversationModel {
  ConversationModel({
    this.conversationId,
    this.username,
    this.firstName,
    this.lastName,
    this.profilePic,
    this.isVerified,
    this.status,
    this.lastMessage,
    this.fromUserId,
    this.toUserId,
    this.media,
    this.mediaType,
    this.createdAt,
    this.updatedAt,
    this.messages,
    this.unreadMessagesCount = 0,
    this.latestMessageDate,
    this.flag,
  });

  ConversationModel.fromJson(dynamic json) {
    conversationId = json['conversation_id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    isVerified = json['verified'];
    status = json['status'];
    lastMessage = json['latest_message'];
    fromUserId = json['from_id'];
    toUserId = json['to_id'];
    media = json['media'];
    mediaType = json['media_type'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    unreadMessagesCount = json['unread_messages_count'];
    latestMessageDate = json['latest_message_date'];
    flag = json['flag'];
  }
  int? conversationId;
  String? username;
  String? firstName;
  String? lastName;
  String? profilePic;
  bool? isVerified;
  bool? status;
  String? lastMessage;
  int? fromUserId;
  int? toUserId;
  String? media;
  String? mediaType;
  String? createdAt;
  String? updatedAt;
  late int unreadMessagesCount;
  String? latestMessageDate;
  List<MessageModel>? messages;
  String? flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['conversation_id'] = conversationId;
    map['username'] = username;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['profile_pic'] = profilePic;
    map['verified'] = isVerified;
    map['status'] = status;
    map['latest_message'] = lastMessage;
    map['from_id'] = fromUserId;
    map['to_id'] = toUserId;
    map['media'] = media;
    map['media_type'] = mediaType;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['unread_messages_count'] = unreadMessagesCount;
    map['latest_message_date'] = latestMessageDate;
    map['flag'] = flag;
    return map;
  }
}