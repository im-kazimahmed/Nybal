class FaqModel {
  FaqModel({
    this.id,
    this.question,
    this.answer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  FaqModel.fromJson(dynamic json) {
    id = json['id'] ;
    question = json['question'];
    answer = json['answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? question;
  String? answer;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['answer'] = answer;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}