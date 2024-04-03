import 'dart:convert';
import 'dart:developer';

import 'package:nybal/models/package_model.dart';
import 'package:nybal/utils/app_tags.dart';

import 'interest_model.dart';

class UserModel {
  int? status;
  String? message;
  String? accessToken;
  UserDataModel? user;
  UserPackage? userPackage;
  List<PackagePermissions>? packagePermissions;

  UserModel(
      {this.status, this.message, this.accessToken, this.user, this.userPackage, this.packagePermissions});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['JWT'];
    user = json['user']['userData'] != null ? UserDataModel.fromJson(
        json['user']['userData']) : null;
    userPackage = json['user']['userDataPackage'] != null ?
    UserPackage.fromJson(json['user']['userDataPackage']) : null;
    if (json['user']['userDataPermissions'] != null) {
      packagePermissions = <PackagePermissions>[];
      json['user']['userDataPermissions'].forEach((v) {
        packagePermissions!.add(PackagePermissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['JWT'] = accessToken;
    data['user'] = {};
    if (user != null) {
      log("here ${user?.toJson()}");
      data['user']['userData'] = user!.toJson();
    }
    if (userPackage != null) {
      data['user']['userDataPackage'] = userPackage!.toJson();
    }
    if (packagePermissions != null) {
      data['user']['userDataPermissions'] =
          packagePermissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }


  void checkPermission(String permissionName) {
    PackagePermissions? permission = packagePermissions?.firstWhere(
          (permission) => permission.permissionName == permissionName,
    );

    if (permission != null) {
      // Check if the permission is enabled
      if (permission.permissionAllow == true) {
        print('Permission "$permissionName" is enabled');

        // Check the permission limit
        if (permission.permissionLimit != null) {
          print('Permission limit: ${permission.permissionLimit}');
        } else {
          print('No permission limit specified');
        }

        // Check sub-permissions
        if (permission.subPermissions != null) {
          // Check if gender is enabled
          dynamic gender = permission.subPermissions?.perGender;

          if (gender is bool) {
            if (gender) {
              print('Gender is enabled');
            } else {
              print('Gender is disabled');
            }
          } else if (gender is Map<String, dynamic>) {
            // Check if female is enabled
            bool? isFemaleEnabled = gender['female'];

            if (isFemaleEnabled == true) {
              // Check the limit for female
              int? femaleLimit = gender['limit'];

              if (femaleLimit != null) {
                print('Female is enabled with a limit of $femaleLimit');
              } else {
                print('Female is enabled with no limit');
              }
            } else {
              print('Female is disabled');
            }

            // Check if male is enabled
            bool? isMaleEnabled = gender['male'];

            if (isMaleEnabled == true) {
              // Check the limit for male
              // (similar to the check for female)
              // ...
            } else {
              print('Male is disabled');
            }
          }
        } else {
          print('No sub-permissions specified');
        }
      } else {
        print('Permission "$permissionName" is disabled');
      }
    } else {
      print('Permission "$permissionName" not found');
    }
  }

}

class UserDataModel {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePic;
  String? gender;
  bool? emailVerify;
  bool? isPro;
  int? packageId;
  String? country;
  String? countryFlag;
  String? state;
  String? city;
  String? dateOfBirth;
  String? maritalStatus;
  int? children;
  String? latitude;
  String? longitude;
  String? deviceId;
  String? deviceToken;
  String? religion;
  String? subReligion;
  String? prayer;
  Appearance? appearance;
  String? financialStatus;
  String? mySpecifications;
  String? partnerSpecs;
  int? monthlyIncome;
  String? education;
  String? ethnicity;
  String? phone;
  String? languagesSpeaks;
  String? aboutMe;
  bool? willingToRelocate;
  bool? verified;
  bool? isGoogleSignedUp;
  bool? isTwitterSignedUp;
  bool? isFacebookSignedUp;
  bool? isNewsLetterEnabled;
  bool? isMarryInterested;
  bool? onlineStatus;
  bool? activateNotifications;
  bool? emailNotificationsEnabled;
  bool? receiveNewMessagesEnabled;
  int? wallet;
  int? wifeOf;
  String? createdAt;
  String? updatedAt;
  bool? hasReported;
  bool? hasBlocked;
  bool? status;
  PhotoPermission? photosPermission;
  dynamic extraField;
  UserDataModel? refBy;
  List<InterestModel>? interestsList;
  int? todayProfileVisits;
  int? weekLikes;

  UserDataModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePic,
    this.gender,
    this.emailVerify,
    this.isPro,
    this.packageId,
    this.country,
    this.countryFlag,
    this.state,
    this.city,
    this.dateOfBirth,
    this.maritalStatus,
    this.children,
    this.latitude,
    this.longitude,
    this.deviceId,
    this.deviceToken,
    this.religion,
    this.subReligion,
    this.prayer,
    this.appearance,
    this.financialStatus,
    this.mySpecifications,
    this.partnerSpecs,
    this.monthlyIncome,
    this.education,
    this.ethnicity,
    this.phone,
    this.languagesSpeaks,
    this.aboutMe,
    this.willingToRelocate,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.isFacebookSignedUp,
    this.isGoogleSignedUp,
    this.isTwitterSignedUp,
    this.onlineStatus,
    this.activateNotifications,
    this.emailNotificationsEnabled,
    this.isMarryInterested,
    this.isNewsLetterEnabled,
    this.receiveNewMessagesEnabled,
    this.extraField,
    this.wallet,
    this.wifeOf,
    this.hasReported,
    this.hasBlocked,
    this.photosPermission,
    this.refBy,
    this.interestsList,
    this.todayProfileVisits,
    this.weekLikes,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    if(json['gender'] is String) {
      gender = json['gender'];
    } else {
      gender = json['gender'] == 1 ? "Male": "Female";
    }
    emailVerify = json['email_verify'];
    isPro = json['is_pro'];
    packageId = json['package_id'];
    country = json['country'];
    if (json['country_flag'] != null) {
      countryFlag = json['country_flag'];
    }
    state = json['state'];
    city = json['city'];
    dateOfBirth = json['dob'];
    maritalStatus = json['marital_status'];
    children = json['children'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
    religion = json['religion'];
    subReligion = json['sub_religion'];
    prayer = json['prayer'];
    if (json['appearance'] != null) {
      if (json['appearance'] is Map<String, dynamic>) {
        appearance = Appearance.fromJson(json['appearance']);
      }
    }
    financialStatus = json['financial_status'];
    mySpecifications = json['my_specification'];
    partnerSpecs = json['partner_specification'];
    monthlyIncome = json['monthly_income'];
    education = json['education'];
    ethnicity = json['ethnicity'];
    phone = json['phone'];
    languagesSpeaks = json['langs_speak'];
    aboutMe = json['about_me'];
    willingToRelocate = json['willing_to_relocate'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    isGoogleSignedUp = json['google_signup'];
    isTwitterSignedUp = json['twitter_signup'];
    isFacebookSignedUp = json['facebook_signup'];
    isNewsLetterEnabled = json['news_letter_approval'];
    isMarryInterested = json['user_marry_interest'];
    onlineStatus = json['online_status'];
    activateNotifications = json['activated_notifications'];
    emailNotificationsEnabled = json['email_notification'];
    receiveNewMessagesEnabled = json['receive_new_messages'];
    extraField = json['extra_field'];
    if(json['wallet'] != null) {
      wallet = json['wallet'];
    }
    if(json['wife_of'] != null) {
      wifeOf = json['wife_of'];
    }
    if(json['has_reported'] != null) {
      hasReported = json['has_reported'];
    }
    if(json['has_blocked'] != null) {
      hasBlocked = json['has_blocked'];
    }
    if(json['photo_permission'] != null) {
      photosPermission = PhotoPermission.fromJson(json['photo_permission']);
    }
    if (json['ref_by'] != null) {
      if (json['ref_by'] is Map<String, dynamic>) {
        refBy = UserDataModel.fromJson(json['ref_by']);
      }
    }
    if (json['user_interests'] != null) {
      interestsList = <InterestModel>[];
      try {
        json['user_interests'].forEach((v) {
          interestsList!.add(InterestModel.fromJson(v));
        });
      } catch (e){
        log("error parsing user interests $e");
      }
    }
    todayProfileVisits = json['todays_vistit'];
    weekLikes = json['week_likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['profile_pic'] = profilePic;
    data['gender'] = gender;
    data['email_verify'] = emailVerify;
    data['is_pro'] = isPro;
    data['package_id'] = packageId;
    data['country'] = country;
    data['country_flag'] = countryFlag;
    data['state'] = state;
    data['city'] = city;
    data['dob'] = dateOfBirth;
    data['marital_status'] = maritalStatus;
    data['children'] = children;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['device_id'] = deviceId;
    data['device_token'] = deviceToken;
    data['religion'] = religion;
    data['sub_religion'] = subReligion;
    data['prayer'] = prayer;
    if (appearance != null) {
      data['appearance'] = appearance?.toJson();
    }
    data['appearance'] = appearance;
    data['financial_status'] = financialStatus;
    data['my_specification'] = mySpecifications;
    data['partner_specification'] = partnerSpecs;
    data['monthly_income'] = monthlyIncome;
    data['education'] = education;
    data['ethnicity'] = ethnicity;
    data['phone'] = phone;
    data['langs_speak'] = languagesSpeaks;
    data['about_me'] = aboutMe;
    data['willing_to_relocate'] = willingToRelocate;
    data['verified'] = verified;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['online_status'] = onlineStatus;
    data['google_signup'] = isGoogleSignedUp;
    data['twitter_signup'] = isTwitterSignedUp;
    data['facebook_signup'] = isFacebookSignedUp;
    data['news_letter_approval'] = isNewsLetterEnabled;
    data['user_marry_interest'] = isMarryInterested;
    data['activated_notifications'] = activateNotifications;
    data['email_notification'] = emailNotificationsEnabled;
    data['receive_new_messages'] = receiveNewMessagesEnabled;
    data['extra_field'] = extraField;
    data['wallet'] = wallet;
    data['wife_of'] = wifeOf;
    data['has_reported'] = hasReported;
    data['photo_permission'] = photosPermission;
    return data;
  }
}

class Appearance {
  String? height;
  String? weight;
  String? skinColor;
  bool? hijab;
  bool? smoking;
  int? beard;
  String? bodyType;

  Appearance({
    this.height,
    this.weight,
    this.skinColor,
    this.hijab,
    this.beard,
    this.smoking,
    this.bodyType,
  });

  Appearance.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    skinColor = json['skin_color'];
    hijab = json['hijab'];
    beard = json['beard'];
    smoking = json['smoking'];
    bodyType = json['body_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['weight'] = weight;
    data['skin_color'] = skinColor;
    data['hijab'] = hijab;
    data['beard'] = beard;
    data['smoking'] = smoking;
    data['body_type'] = bodyType;
    return data;
  }
}


class PhotoPermission {
  bool? hasAsked;
  int? status;

  PhotoPermission({
    this.hasAsked,
    this.status,
  });

  PhotoPermission.fromJson(Map<String, dynamic> json) {
    hasAsked = json['hasAsked'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hasAsked'] = hasAsked;
    data['status'] = status;
    return data;
  }
}

