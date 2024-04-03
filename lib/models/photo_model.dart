class PhotoModel {
  PhotoModel({
    this.id,
    this.userId,
    this.image,
  });

  PhotoModel.fromJson(dynamic json) {
    id = json['id'] ;
    userId = json['user_id'];
    image = json['image'];
  }
  int? id;
  int? userId;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['image'] = image;
    return map;
  }
}