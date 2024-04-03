class InterestModel {
  InterestModel({
    this.id,
    required this.title,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  InterestModel.fromJson(dynamic json) {
    if(json['id'] != null) {
      id = json['id'];
    }
    if(json['name'] != null) {
      title = json['name'];
    }
    if(json['image'] != null) {
      image = json['image'];
    }
    if(json['status'] != null) {
      status = json['status'] == 1 ? true: false;
    }
    if(json['created_at'] != null) {
      createdAt = json['created_at'];
    }
    if(json['updated_at'] != null) {
      updatedAt = json['updated_at'];
    }
  }
  int? id;
  late String title;
  String? image;
  bool? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = title;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}