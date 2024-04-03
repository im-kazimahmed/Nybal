import 'dart:developer';

class UserPackage {
  int? id;
  String? name;
  String? description;
  int? price;
  int? duration;
  bool? status;
  String? createdAt;
  String? updatedAt;
  bool? isSpecialPackage;

  UserPackage(
    {
      this.id,
      this.name,
      this.description,
      this.price,
      this.duration,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isSpecialPackage,
    });

  UserPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    status = json['status'];
    if (json['special_package'] != null && json['special_package'] != "") {
      if(json['special_package'] == "1" || json['special_package'] == 1) {
        isSpecialPackage = true;
      } else {
        isSpecialPackage = false;
      }
    } else {
      isSpecialPackage = false;
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['duration'] = duration;
    data['status'] = status;
    data['special_package'] = isSpecialPackage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PackagePermissions {
  int? id;
  int? packageId;
  String? permissionName;
  bool? permissionAllow;
  int? permissionLimit;
  SubPermissions? subPermissions;
  String? createdAt;
  String? updatedAt;

  PackagePermissions(
      {
        this.id,
        this.packageId,
        this.permissionName,
        this.permissionAllow,
        this.permissionLimit,
        this.subPermissions,
        this.createdAt,
        this.updatedAt,
      });

  PackagePermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    permissionName = json['permission_name'];
    permissionAllow = json['permission_allow'];
    permissionLimit = json['permission_limit'];
    subPermissions = json['sub_permissions'] != null
        ? SubPermissions.fromJson(json['sub_permissions'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_id'] = packageId;
    data['permission_name'] = permissionName;
    data['permission_allow'] = permissionAllow;
    data['permission_limit'] = permissionLimit;
    if (subPermissions != null) {
      data['sub_permissions'] = subPermissions!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SubPermissions {
  bool? subscribedOn;
  bool? perCountry;
  bool? isPerGenderDisabled;
  PerGender? perGender;

  SubPermissions({this.subscribedOn, this.perCountry, this.perGender});

  SubPermissions.fromJson(Map<String, dynamic> json) {
    subscribedOn = json['subscribed_on'];
    perCountry = json['per_country'];
    if(json['per_gender'] != null) {
     if(json['per_gender'] is bool) {
       isPerGenderDisabled = json['per_gender'];
     } else {
       perGender = PerGender.fromJson(json['per_gender']);
     }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscribed_on'] = subscribedOn;
    data['per_country'] = perCountry;
    if (perGender != null) {
      data['per_gender'] = perGender!.toJson();
    }
    return data;
  }
}

class PerGender {
  dynamic male;
  dynamic female;

  PerGender({this.male, this.female});

  PerGender.fromJson(Map<String, dynamic> json) {
    male = json['male'];
    female = json['female'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['male'] = male;
    data['female'] = female;
    return data;
  }

  bool isMaleBoolean() {
    return male is bool;
  }

  bool isFemaleBoolean() {
    return female is bool;
  }

  bool isMaleMap() {
    return male is Map<String, dynamic>;
  }

  bool isFemaleMap() {
    return female is Map<String, dynamic>;
  }

  bool isMaleMapWithLimit() {
    return isMaleMap() && male.containsKey('limit') && male['limit'] is int;
  }

  bool isFemaleMapWithLimit() {
    return isFemaleMap() && female.containsKey('limit') && female['limit'] is int;
  }

  bool getMaleBoolean() {
    if (isMaleBoolean()) {
      return male as bool;
    }
    return false;
  }

  bool getFemaleBoolean() {
    if (isFemaleBoolean()) {
      return female as bool;
    }
    return false;
  }

  int? getMaleLimit() {
    if (isMaleMapWithLimit()) {
      return male['limit'] as int?;
    }
    return null;
  }

  int? getFemaleLimit() {
    if (isFemaleMapWithLimit()) {
      return female['limit'] as int?;
    }
    return null;
  }
}
