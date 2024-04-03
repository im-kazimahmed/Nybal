class GenderModel {
  GenderModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  GenderModel.fromJson(dynamic json) {
    id = json['id'] ;
    name = json['gender'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['gender'] = name;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}