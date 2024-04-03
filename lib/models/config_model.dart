import 'dart:developer';

class ConfigModel {
  int? status;
  bool? success;
  String? message;
  AppConfig? appConfig;

  ConfigModel({this.status, this.success, this.message, this.appConfig});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    appConfig =
    json['app_config'] != null ? AppConfig.fromJson(json['app_config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    if (appConfig != null) {
      data['app_config'] = appConfig!.toJson();
    }
    return data;
  }
}

class AppConfig {
  SignupField? signupFieldsRequired;
  bool? emailVerificationSystem;
  int? discountOnSpotlight;
  int? discountOnSubscription;
  String? googleIosKey;
  String? googleAndroidKey;
  String? googleWebKey;
  PaymentMethod? payments;
  List<Languages>? languages;
  SocialMedia? socialMediaLogin;
  AdditionFields? additionalFieldsRequired;
  List<Educations>? educations;

  AppConfig({
    this.signupFieldsRequired,
    this.emailVerificationSystem,
    this.discountOnSpotlight,
    this.discountOnSubscription,
    this.googleIosKey,
    this.googleAndroidKey,
    this.googleWebKey,
    this.payments,
    this.languages,
    this.socialMediaLogin,
  });

  AppConfig.fromJson(Map<String, dynamic> json) {
    if (json['signup_fields_required'] != null) {
      signupFieldsRequired = SignupField.fromJson(json['signup_fields_required']);
    }
    emailVerificationSystem = json['email_verification_system'];
    discountOnSpotlight = json['discount_on_spotlight'];
    discountOnSubscription = json['discount_on_subscription'];
    googleIosKey = json['google_ios_key'];
    googleAndroidKey = json['google_android_key'];
    googleWebKey = json['google_web_key'];
    if (json['payments'] != null) {
      payments = PaymentMethod.fromJson(json['payments']);
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations!.add(Educations.fromJson(v));
      });
    }
    if (json['social_media_login'] != null) {
      socialMediaLogin = SocialMedia.fromJson(json['social_media_login']);
    }
    if (json['additional_fields_required'] != null) {
      additionalFieldsRequired = AdditionFields.fromJson(json['additional_fields_required']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (signupFieldsRequired != null) {
      data['signup_fields_required'] = signupFieldsRequired;
    }
    data['email_verification_system'] = emailVerificationSystem;
    if(discountOnSpotlight != null) {
      data['discount_on_spotlight'] = discountOnSpotlight;
    }
    if(discountOnSubscription != null) {
      data['discount_on_subscription'] = discountOnSubscription;
    }
    data['google_ios_key'] = googleIosKey;
    data['google_android_key'] = googleAndroidKey;
    data['google_web_key'] = googleWebKey;
    if (payments != null) {
      data['payments'] = payments;
    }
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    if (socialMediaLogin != null) {
      data['social_media_login'] = socialMediaLogin;
    }
    if (additionalFieldsRequired != null) {
      data['additional_fields_required'] = additionalFieldsRequired;
    }
    return data;
  }
}

class SignupField {
  bool? isUsernameEnabled;
  bool? isFirstNameEnabled;
  bool? isLastNameEnabled;
  // bool? isEmailEnabled;
  // bool? isPasswordEnabled;
  bool? isGenderEnabled;

  SignupField({this.isUsernameEnabled,
    this.isFirstNameEnabled,
    this.isLastNameEnabled,
    // this.isEmailEnabled,
    // this.isPasswordEnabled,
    this.isGenderEnabled,
  });

  SignupField.fromJson(Map<String, dynamic> json) {
    isUsernameEnabled = json['username'];
    isFirstNameEnabled = json['first_name'];
    isLastNameEnabled = json['last_name'];
    // isEmailEnabled = json['email'];
    // isPasswordEnabled = json['password'];
    isGenderEnabled = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = isUsernameEnabled;
    data['first_name'] = isFirstNameEnabled;
    data['last_name'] = isLastNameEnabled;
    // data['email'] = isEmailEnabled;
    // data['password'] = isPasswordEnabled;
    data['gender'] = isGenderEnabled;
    return data;
  }
}

class AdditionFields {
  bool? isEducationEnabled;
  bool? isStateEnabled;
  bool? isCityEnabled;
  bool? isMaritalStatusEnabled;
  bool? isChildrenEnabled;
  bool? isLatitudeEnabled;
  bool? isLongitudeEnabled;
  bool? isSubReligionEnabled;
  bool? isPrayerEnabled;
  bool? isAppearanceEnabled;
  bool? isFinancialStatusEnabled;
  bool? isMySpecsEnabled;
  bool? isPartnerSpecsEnabled;
  bool? isMonthlyIncomeEnabled;
  bool? isEthnicityEnabled;
  bool? isLangSpeaksEnabled;
  bool? isAboutMeEnabled;
  bool? isWillingToRelocateEnabled;

  AdditionFields({
    this.isEducationEnabled,
    this.isStateEnabled,
    this.isCityEnabled,
    this.isMaritalStatusEnabled,
    this.isChildrenEnabled,
    this.isLatitudeEnabled,
    this.isLongitudeEnabled,
    this.isSubReligionEnabled,
    this.isPrayerEnabled,
    this.isAppearanceEnabled,
    this.isFinancialStatusEnabled,
    this.isMySpecsEnabled,
    this.isPartnerSpecsEnabled,
    this.isMonthlyIncomeEnabled,
    this.isEthnicityEnabled,
    this.isLangSpeaksEnabled,
    this.isAboutMeEnabled,
    this.isWillingToRelocateEnabled,
  });

  AdditionFields.fromJson(Map<String, dynamic> json) {
    isEducationEnabled = json['education'];
    isStateEnabled = json['state'];
    isCityEnabled = json['city'];
    isMaritalStatusEnabled = json['marital_status'];
    isChildrenEnabled = json['children'];
    isLatitudeEnabled = json['latitude'];
    isLongitudeEnabled = json['longitude'];
    isSubReligionEnabled = json['sub_religion'];
    isPrayerEnabled = json['prayer'];
    isAppearanceEnabled = json['appearance'];
    isFinancialStatusEnabled = json['financial_status'];
    isMySpecsEnabled = json['my_specification'];
    isPartnerSpecsEnabled = json['partner_specification'];
    isMonthlyIncomeEnabled = json['monthly_income'];
    isEthnicityEnabled = json['ethnicity'];
    isLangSpeaksEnabled = json['langs_speak'];
    isAboutMeEnabled = json['about_me'];
    isWillingToRelocateEnabled = json['willing_to_relocate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['education'] = isEducationEnabled;
    data['state'] = isStateEnabled;
    data['city'] = isCityEnabled;
    data['marital_status'] = isMaritalStatusEnabled;
    data['children'] = isChildrenEnabled;
    data['latitude'] = isLatitudeEnabled;
    data['longitude'] = isLongitudeEnabled;
    data['sub_religion'] = isSubReligionEnabled;
    data['prayer'] = isPrayerEnabled;
    data['appearance'] = isAppearanceEnabled;
    data['financial_status'] = isFinancialStatusEnabled;
    data['my_specification'] = isMySpecsEnabled;
    data['partner_specification'] = isPartnerSpecsEnabled;
    data['monthly_income'] = isMonthlyIncomeEnabled;
    data['ethnicity'] = isEthnicityEnabled;
    data['langs_speak'] = isLangSpeaksEnabled;
    data['about_me'] = isAboutMeEnabled;
    data['willing_to_relocate'] = isWillingToRelocateEnabled;
    return data;
  }
}

class PaymentMethod {
  bool? isPaypalEnabled;
  bool? isStripeEnabled;

  PaymentMethod({this.isPaypalEnabled, this.isStripeEnabled});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    isPaypalEnabled = json['paypal'];
    isStripeEnabled = json['stripe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paypal'] = isPaypalEnabled;
    data['stripe'] = isStripeEnabled;
    return data;
  }
}

class Languages {
  int? id;
  String? name;
  String? key;
  bool? isEnabled;
  String? createdAt;
  String? updatedAt;

  Languages({this.id, this.name, this.key, this.isEnabled, this.createdAt, this.updatedAt});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    key = json['_key'];
    isEnabled = bool.parse(json['isEnabled'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_key'] = key;
    data['isEnabled'] = isEnabled;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


class Educations {
  int? id;
  String? title;

  Educations({this.id, this.title});

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class SocialMedia {
  bool? isGoogleEnabled;
  bool? isTwitterEnabled;
  bool? isFacebookEnabled;

  SocialMedia({this.isGoogleEnabled, this.isTwitterEnabled, this.isFacebookEnabled});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    isGoogleEnabled = json.containsKey('google') ? json['google'] as bool? : null;
    isTwitterEnabled = json.containsKey('twitter') ? json['twitter'] as bool? : null;
    isFacebookEnabled = json.containsKey('facebook') ? json['facebook'] as bool? : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'google': isGoogleEnabled,
      'twitter': isTwitterEnabled,
      'facebook': isFacebookEnabled,
    };
    return data;
  }
}

