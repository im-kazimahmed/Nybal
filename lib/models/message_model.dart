class MessageModel {
  String messageText;
  String? media;
  String? mediaType;
  int fromId;
  int toId;
  String sender;
  String? senderProfilePic;
  String? receiverProfilePic;
  String? receiver;
  String? msgTime;

  MessageModel({
    required this.messageText,
    required this.media,
    required this.mediaType,
    required this.fromId,
    required this.toId,
    required this.sender,
    required this.senderProfilePic,
    required this.receiverProfilePic,
    required this.receiver,
    this.msgTime
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageText: json['message_text'],
      media: json['media'],
      mediaType: json['media_type'],
      fromId: json['from_id'],
      toId: json['to_id'],
      sender: json['sender'],
      senderProfilePic: json['sender_profile_pic'],
      receiverProfilePic: json['receiver_profile_pic'],
      receiver: json['receiver'],
      msgTime: json['created_at'],
    );
  }
}
