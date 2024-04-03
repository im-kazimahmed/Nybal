class FirebaseUserModel{
  late String id;
  late String name;
  late String email;
  late String avatar;
  late int appUserId;
  bool busy = false;

  FirebaseUserModel({
    required this.name,
    required this.avatar,
  });

  FirebaseUserModel.register({required this.name, required this.id,required this.email,required this.avatar,required this.busy, required this.appUserId});

  FirebaseUserModel.fromJsonMap({required Map<String, dynamic> map,required String uId}){
    id = uId;
    name = map["name"];
    email = map["email"];
    avatar = map["avatar"];
    busy = map["busy"];
    appUserId = map['appUserId'];
  }

  Map<String,dynamic> toMap(){
    return {
      "uId": id,
      "name": name,
      "email": email,
      "avatar": avatar,
      "busy": busy,
      "appUserId": appUserId,
    };
  }
}

class UserFcmTokenModel{
  late String uId, token;

  UserFcmTokenModel({required this.uId, required this.token});

  UserFcmTokenModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'token': token,
    };
  }
}