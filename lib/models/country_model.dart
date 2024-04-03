class CountryModel {
  CountryModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CountryModel.fromJson(dynamic json) {
    id = json['id'] ;
    name = json['name'];
    flag = json['flag'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? flag;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['flag'] = flag;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class StateModel {
  StateModel({
    this.id,
    this.countryId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  StateModel.fromJson(dynamic json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? countryId;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country_id'] = countryId;
    map['name'] = name;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class CityModel {
  CityModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CityModel.fromJson(dynamic json) {
    id = json['id'] ;
    name = json['name'];
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
    map['name'] = name;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}