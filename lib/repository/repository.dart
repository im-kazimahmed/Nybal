import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nybal/controllers/auth_controller.dart';
import 'package:nybal/controllers/language_controller.dart';
import 'package:nybal/models/conversation_model.dart';
import 'package:nybal/models/interest_model.dart';
import 'package:nybal/models/package_model.dart';
import 'package:nybal/models/photo_model.dart';
import 'package:nybal/models/ticket_model.dart';
import 'package:nybal/utils/functions.dart';
import '../Widgets/dialogs.dart';
import '../config/api_routes.dart';
import '../controllers/setting_controller.dart';
import '../controllers/user_controller.dart';
import '../helpers/local_data_helper.dart';
import '../models/config_model.dart';
import '../models/country_model.dart';
import '../models/faq_model.dart';
import '../models/notification_model.dart';
import '../models/religion_model.dart';
import '../models/user_model.dart';
import '../utils/utility.dart';
import '../utils/validators.dart';
import 'network_service.dart';
import 'package:flutter/foundation.dart';

class Repository {
  final NetworkService _service = NetworkService();
  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.find<AuthController>();
  final LanguageController langController = Get.find<LanguageController>();
  final SettingController settingController = Get.find<SettingController>();

  Map<String, String> headers = {
    // 'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsInVzZXJuYW1lIjoidGFoYSIsImlhdCI6MTY5NTkwMTc1MiwiZXhwIjoxNjk1OTg4MTUyfQ.PxFG5YckzB8C8FVlI_wUfLCYdZjlCjKM3vR-JyWD16I",
    'Authorization': "${LocalDataHelper().getUserToken()}",
    'user_id': LocalDataHelper().getUserId().toString(),
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*", // Required for CORS support to work
  };

  //User Login
  Future<bool> loginWithEmailPassword(String email, String password, String ipAddress, String? deviceToken) async {
    try {
      Dialogs.showLoadingDialog();
      var body = deviceToken != null ? {
        'email': email,
        'password': password,
        'ip_address': ipAddress,
        'device_token': deviceToken,
      }: {
        'email': email,
        'password': password,
        'ip_address': ipAddress,
      };
      var url = Uri.parse(ApiRoutes.loginApi);
      final response = await http.post(
        url,
        body: json.encode(body),
        headers: headers,
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data['message'] == "User Device is banned") {
          Get.back();

          if(kIsWeb) {
            showCustomSnackBar(data['message']);
          } else {
            showShortToast(data['message'], bgColor: Colors.green);
          }
          return false;
        } else {
          print(data);
          UserModel userDataModel = UserModel.fromJson(data);
          userController.userData = userDataModel;
          LocalDataHelper().saveUserAllData(userDataModel);
          if (authController.isIncognito.value) {
            authController.emailController.clear();
            authController.passwordController.clear();
            LocalDataHelper().box.remove("mail");
            LocalDataHelper().box.remove("pass");
            LocalDataHelper().saveUserTokenIncognito(
              userDataModel.accessToken.toString(),
              userDataModel.user!.id!,
            );
          } else {
            LocalDataHelper().saveUserTokenWithExpiry(
              userDataModel.accessToken.toString(),
              userDataModel.user!.id!,
            );
          }
          // await AppUtility.saveChannelDataToLocalStorage();
          authController.chatSocketLogin(
            name: "${userDataModel.user?.firstName} ${userDataModel.user?.lastName}",
            id: "${userDataModel.user?.id}",
            profilePic: "${userDataModel.user?.profilePic}",
          );
          userController.getAllUsers();
          settingController.getCountriesList();
          userController.getAllUserConversations();
          // authCubit.login(
          //   email: email,
          //   password: password,
          // );
          if(kIsWeb) {
            showCustomSnackBar(data['message']);
          } else {
            showShortToast(data['message'], bgColor: Colors.green);
          }
          Get.back();
          return true;
        }
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        // if(data['status'] == 401) {
        //   Dialogs.showAlertDialog(
        //     "Verification",
        //     "Your account seems to be not verified, please verify your account in order to use it",
        //   );
        // }
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("Sign-in failed: ${e.message}");
      } else {
        showErrorToast("Sign-in failed: ${e.message}");
      }
      return false;
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  Future<bool> resendEmailVerification(int userId) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.resendEmailVerificationApi);
      final response = await http.post(
        url,
        body: json.encode({
          "id": userId
        }),
        headers: headers,
      );

      var data = json.decode(response.body);
      print(data);

      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  Future<bool> emailVerification(String otpCode, int userId) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.emailVerificationApi);
      final response = await http.post(
        url,
        body: json.encode({
          "user_id": userId,
          "code": otpCode
        }),
        headers: headers,
      );

      var data = json.decode(response.body);
      print(data);

      if (response.statusCode == 200) {
        // UserModel userDataModel = UserModel.fromJson(data);
        // userController.userData = userDataModel;
        // LocalDataHelper().saveUserAllData(userDataModel);
        // LocalDataHelper().saveUserTokenWithExpiry(userDataModel.accessToken.toString());

        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        authController.otpController.clear();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  //General User SignUp
  Future<UserModel?> signUp({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required int gender,
    required String ipAdd,
    required String deviceId,
    required String referredBy,
    String? deviceToken,
  }) async {
    Dialogs.showLoadingDialog();
    try {
      var body = {
        'username': userName,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'gender': "$gender",
        'ip_address': ipAdd,
        'device_id': deviceId,
        'device_token': deviceToken,
        'ref_by': referredBy,
      };
      var url = Uri.parse(ApiRoutes.registerApi);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data['message'] != "User Device is banned") {
          print("sign up response ${data}");
          UserModel userDataModel = UserModel.fromJson(data);
          userController.userData = userDataModel;
          LocalDataHelper().saveUserAllData(userDataModel);
          LocalDataHelper().saveUserTokenWithExpiry(
              userDataModel.accessToken.toString(),
              userDataModel.user!.id!
          );
          authController.chatSocketLogin(
            name: "${userDataModel.user?.firstName} ${userDataModel.user?.lastName}",
            id: "${userDataModel.user?.id}",
            profilePic: "${userDataModel.user?.profilePic}",
          );
          await AppUtility.saveChannelDataToLocalStorage();
          userController.getAllUsers();
          settingController.getCountriesList();
          userController.getAllUserConversations();
          // authCubit.register(
          //   name: firstName,
          //   email: email,
          //   password: password,
          //   profilePicture: "${userDataModel.user?.profilePic}",
          //   appUserId: userDataModel.user!.id!,
          // );
          return userDataModel;
        } else {
          if(kIsWeb) {
            showCustomSnackBar(data['message']);
          } else {
            showErrorToast(data['message']);
          }
          Get.back();
        }
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data['message']);
        }
        return null;
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("Sign-in failed: ${e.message}");
      } else {
        showErrorToast("Sign-in failed: ${e.message}");
      }
      return null;
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return null;
    }
  }

  //Social User SignUp
  Future<bool> socialSignUp({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String photoUrl,
    required String ipAdd,
    required String uniqueDeviceToken,
    required String deviceID,
    required String referredBy,
  }) async {
    try {
      var body = {
        "first_name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "profile_pic": photoUrl,
        "ip_address": ipAdd,
        "device_token": uniqueDeviceToken,
        "device_id": deviceID
      };
      var url = Uri.parse(ApiRoutes.registerSocialGoogleApi);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        UserModel userDataModel = UserModel.fromJson(data);
        userController.userData = userDataModel;
        LocalDataHelper().saveUserAllData(userDataModel);
        LocalDataHelper().saveUserTokenWithExpiry(
            userDataModel.accessToken.toString(),
            userDataModel.user!.id!
        );
        authController.chatSocketLogin(
          name: "${userDataModel.user?.firstName} ${userDataModel.user?.lastName}",
          id: "${userDataModel.user?.id}",
          profilePic: "${userDataModel.user?.profilePic}",
        );
        // await AppUtility.saveChannelDataToLocalStorage();
        userController.getAllUsers();
        settingController.getCountriesList();
        userController.getAllUserConversations();
        // authCubit.register(
        //   name: name,
        //   email: email,
        //   password: password,
        //   profilePicture: "${userDataModel.user?.profilePic}",
        //   appUserId: userDataModel.user!.id!,
        // );
        showShortToast("Welcome to nybal", bgColor: Colors.green);
        return true;
      } else {
        showErrorToast(data['message']);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      showErrorToast("Failed: ${e.message}");
      return false;
    } catch (e) {
      showErrorToast("An error occurred: $e");
      return false;
    }
  }

  //Social User SignUp
  Future<bool> socialSignIn({
    required String email,
    required String password,
    required String ipAddress,
    String? deviceToken,
  }) async {
    try {
      var body = deviceToken != null ? {
        "email": email,
        "password": password,
        "ip_address": ipAddress,
        "device_token": deviceToken,
      }:{
        "email": email,
        "password": password,
        "ip_address": ipAddress,
      };
      var url = Uri.parse(ApiRoutes.socialGoogleLoginApi);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        UserModel userDataModel = UserModel.fromJson(data);
        userController.userData = userDataModel;
        LocalDataHelper().saveUserAllData(userDataModel);
        LocalDataHelper().saveUserTokenWithExpiry(
            userDataModel.accessToken.toString(),
            userDataModel.user!.id!
        );
        authController.chatSocketLogin(
          name: "${userDataModel.user?.firstName} ${userDataModel.user?.lastName}",
          id: "${userDataModel.user?.id}",
          profilePic: "${userDataModel.user?.profilePic}",
        );
        // await AppUtility.saveChannelDataToLocalStorage();
        userController.getAllUsers();
        settingController.getCountriesList();
        userController.getAllUserConversations();
        // authCubit.login(
        //   email: email,
        //   password: password,
        // );
        showShortToast("Welcome back", bgColor: Colors.green);
        return true;
      } else {
        String? msg = data['message'];
        if(msg == "User Not Found") {
          return false;
        } else {
          showErrorToast(data['message']);
          return false;
        }
      }
    } on FirebaseAuthException catch (e) {
      showErrorToast("Sign-in failed: ${e.message}");
      return false;
    } catch (e) {
      showErrorToast("An error occurred: $e");
      return false;
    }
  }

  Future<List<FaqModel>?> getFaqsList() async {
    try {
      var url = Uri.parse(ApiRoutes.getFaqsApi);
      final response = await http.get(url, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        List<FaqModel> parsedData = data['faqs'].map<FaqModel>((item) {
          return FaqModel.fromJson(item);
        }).toList();

        return parsedData;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch(e) {
      return null;
    }
  }

  Future<List<ReligionModel>?> getReligionsList() async {
    try {
      var url = Uri.parse(ApiRoutes.getReligionsApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(response.body.contains("religions") && data["religions"] != null) {
          List<ReligionModel> parsedData = data['religions'].map<ReligionModel>((item) {
            return ReligionModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<UserPackage>?> getPackagesList() async {
    try {
      var url = Uri.parse(ApiRoutes.getPackagesApi);
      final response = await http.get(url, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        List<dynamic>? packageData = data['packages'];
        if (packageData != null) {
          List<UserPackage> parsedData = packageData.map<UserPackage>((item) {
            return UserPackage(
              id: item['id'],
              name: item['name'],
              description: item['description'],
              price: item['price'],
              duration: item['duration'],
              isSpecialPackage: item['special_package'] == "1" || item['special_package'] == 1,
              createdAt: item['created_at']
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        final data = json.decode(response.body);
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<CountryModel>?> getCountriesList() async {
    try {
      var url = Uri.parse(ApiRoutes.getCountriesApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      log("on country $data");
      if (response.statusCode == 200) {
        if(response.body.contains("countries")) {
          List<CountryModel> parsedData = data['countries'].map<CountryModel>((item) {
            return CountryModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<StateModel>?> getStatesListByCountry(String countryId) async {
    try {
      var url = Uri.parse("${ApiRoutes.getStatesByCountryApi}/$countryId");
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['states'] is List) {
          List<StateModel> parsedData = (data['states'] as List)
              .map<StateModel>((item) => StateModel.fromJson(item))
              .toList();

          return parsedData;
        } else {
          return null;
        }
        // if(response.body.contains("states")) {
        //   List<StateModel> parsedData = data['states'][0].map<StateModel>((item) {
        //     return StateModel.fromJson(item);
        //   }).toList();
        //
        //   return parsedData;
        // } else {
        //   return null;
        // }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<CityModel>?> getCitiesListByState(String stateId) async {
    try {
      var url = Uri.parse("${ApiRoutes.getCitiesByStateApi}/$stateId");
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(response.body.contains("cities")) {
          List<CityModel> parsedData = data['cities'].map<CityModel>((item) {
            return CityModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  Future<List<ReligionModel>?> getSubReligionByReligionId(String religionId) async {
    try {
      var url = Uri.parse("${ApiRoutes.getSubReligionsByReligionIdApi}/$religionId");
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['subReligions'] is List) {
          List<ReligionModel> parsedData = (data['subReligions'] as List)
              .map<ReligionModel>((item) => ReligionModel.fromJson(item))
              .toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUserInformation({
    String? country,
    String? state,
    String? city,
    String? dob,
    String? maritalStatus,
    String? latitude,
    String? longitude,
    String? religion,
    String? subReligion,
    String? education,
    String? prayer,
    Map<String, dynamic>? appearance,
    String? financialStatus,
    String? mySpecification,
    String? partnerSpecification,
    String? monthlyIncome,
    String? ethnicity,
    String? phone,
    String? children,
    List<String>? langSpeak,
    String? aboutMe,
    String? willingToRelocate,
    String? profilePic,
    int? selectedCountryId,
  }) async {
    try {
      var body = {
        "country": country,
        "country_flag_id": selectedCountryId,
        "state": state,
        "city": city,
        "dob": dob,
        "marital_status": maritalStatus,
        "latitude": latitude,
        "longitude": longitude,
        "religion": religion,
        "sub_religion": subReligion,
        "prayer": prayer,
        "appearance": appearance,
        "financial_status": financialStatus,
        "my_specification": mySpecification,
        "partner_specification": partnerSpecification,
        "monthly_income": monthlyIncome,
        "ethnicity": ethnicity,
        "phone": phone,
        "langs_speak": langSpeak.toString(),
        "about_me": aboutMe,
        "willing_to_relocate": willingToRelocate,
        "profile_pic": profilePic,
        "education": education ?? "",
        "children": children
      };
      var url = Uri.parse(ApiRoutes.updateUserInformationApi);
      final response = await http.post(
        url,headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data['user'] != null) {
          UserModel userDataModel = UserModel.fromJson(data);
          log("profile updated ${userDataModel.user?.toJson()}");
          userController.userData = userDataModel;
          LocalDataHelper().saveUserAllData(userDataModel);
          return true;
        } else {
          showShortToast(data["message"]);
          return false;
        }
      } else {
        showErrorToast(data['message']);
        return false;
      }
    } catch (e) {
      print("exception $e");
      return false;
    }
  }

  // Get Potential Matches Home Screen
  Future<List<UserDataModel>?> getPotentialMatches() async {
    // try {
      var url = Uri.parse(ApiRoutes.getPotentialMatchesApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data["result"] != null) {
          List<UserDataModel> parsedData = (data['result'] as List).map((item) {
            return UserDataModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    // } catch (e) {
    //   log("error while parsing user data $e");
    //   return null;
    // }
  }

  // Get Spotlight users
  Future<List<UserDataModel>?> getSpotlightUsers() async {
    try {
      var url = Uri.parse(ApiRoutes.getSpotlightUsersApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data["spotlights"] != null) {
          List<UserDataModel> parsedData = (data['spotlights'] as List).map((item) {
            return UserDataModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get Users who wish to marry
  Future<List<UserDataModel>?> getUsersWhoWishToMarry() async {
    try {
      var url = Uri.parse(ApiRoutes.getUsersWoWishToMarryApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data["result"] != null) {
          List<UserDataModel> parsedData = (data['result'] as List).map((item) {
            return UserDataModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Create user conversation
  Future<ConversationModel?> createUserConversation({required int fromUserId, required int toUserId}) async {
    try {
      var url = Uri.parse(ApiRoutes.createUserConversationApi);
      var body = {
        "from_id": fromUserId,
        "to_id": toUserId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      log("response $data");
      if (response.statusCode == 200) {
        if (data["conversation"] != null && data["conversation"].isNotEmpty) {
          ConversationModel parsedData = ConversationModel.fromJson(data['conversation'][0]['user_data']);
          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get All User Conversations
  Future<List<ConversationModel>?> getUserConversations() async {
    try {
      var url = Uri.parse(ApiRoutes.getUserConversationsApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["conversation"] != null) {
          List<ConversationModel> parsedData = (data['conversation'] as List)
              .map((item) {
                // print("on json $item");
            return ConversationModel.fromJson(item['user_data']);
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get Individual User Conversation
  Future<ConversationModel?> getIndividualConversation({required int toUserId}) async {
    try {
      var url = Uri.parse(ApiRoutes.getIndividualConversationApi);
      var body = {
        "to_id": toUserId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      log("response $data");
      if (response.statusCode == 200) {
        if (data["conversation"] != null && data["conversation"].isNotEmpty) {
          ConversationModel parsedData = ConversationModel.fromJson(data['conversation'][0]['user_data']);
          return parsedData;
        } else {
          return null;
        }
      } else {
        // showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Delete single conversation
  Future<bool?> deleteSingleConversation({required int conversationId}) async {
    try {
      var url = Uri.parse("${ApiRoutes.deleteConversationApi}/$conversationId");
      final response = await http.get(
        url,
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Mark as read single conversation
  Future<bool?> markAsReadConversation({required int conversationId}) async {
    try {
      var url = Uri.parse("${ApiRoutes.markAsReadConversationApi}/$conversationId");
      final response = await http.get(
        url,
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Mark as read selected conversations
  Future<bool?> markAsReadSelectedConversations({required List<int> conversationIds}) async {
    try {
      var url = Uri.parse(ApiRoutes.markReadSelectedConversationsApi);
      var body = {
        "conversationIds": conversationIds,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Delete selected conversations
  Future<bool?> deleteSelectedConversations({required List<int> conversationIds}) async {
    try {
      var url = Uri.parse(ApiRoutes.deleteSelectedConversationsApi);
      var body = {
        "conversationIds": conversationIds,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get All User Photos
  Future<List<PhotoModel>?> getUserPhotos(int userId) async {
    try {
      var url = Uri.parse(ApiRoutes.getUserAllPhotosApi);
      var body = {
        "user_id": userId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["gallery_images"] != null && data["gallery_images"].isNotEmpty) {
          List<PhotoModel> parsedData = (data['gallery_images'] as List)
              .map((item) {
            return PhotoModel.fromJson(item);
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Upload User Photo
  Future<PhotoModel?> uploadUserGalleryPhoto(int userId, String base64Image) async {
    try {
      var url = Uri.parse(ApiRoutes.uploadGalleryPhotoApi);
      var body = {
        "image": [base64Image],
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["gallery_images"] != null && data["gallery_images"].isNotEmpty) {
          return PhotoModel.fromJson(data["gallery_images"]);
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Delete Gallery Photo
  Future<bool?> deleteGalleryPhoto({required int photoId}) async {
    try {
      var url = Uri.parse(ApiRoutes.deleteGalleryPhotoApi);
      var body = {
        "picture_id": photoId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Grant Gallery Photos Permission
  Future<bool?> grantGalleryPermissionToUser({required int userId}) async {
    try {
      var url = Uri.parse(ApiRoutes.grantGalleryPermissionApi);
      var body = {
        "user_id": userId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get All Users Who Visited My Profile
  Future<List<UserDataModel>?> getWhoVisitedMyProfile() async {
    try {
      var url = Uri.parse(ApiRoutes.getWhoVisitedMyProfileApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["visited_users"] != null) {
          List<UserDataModel> parsedData = (data['visited_users'] as List)
              .map((item) {
            return UserDataModel(
              id: item['id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get All Blocked Users
  Future<List<UserDataModel>?> getBlockedUsers() async {
    try {
      var url = Uri.parse(ApiRoutes.getBlockedUsersApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["blockedUsers"] != null) {
          List<UserDataModel> parsedData = (data['blockedUsers'] as List)
              .map((item) {
            return UserDataModel(
              id: item['user_id'],
              extraField: item['id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get All Ignored Users
  Future<List<UserDataModel>?> getIgnoredUsers() async {
    try {
      var url = Uri.parse(ApiRoutes.getIgnoredUsersApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["users"] != null) {
          List<UserDataModel> parsedData = (data['users'] as List).map((item) {
            return UserDataModel(
              id: item['ignored_user_id'],
              extraField: item['id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // block User
  Future<bool?> blockUser({required int userId}) async {
    try {
      var url = Uri.parse(ApiRoutes.blockUserApi);
      var body = {
        "block_user_id": userId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["message"] == "User Blocked Successfully") {
          return true;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Unblock Blocked User
  Future<bool?> unblockBlockedUser({required int recordId}) async {
    try {
      var url = Uri.parse(ApiRoutes.unblockBlockedUserApi);
      var body = {
        "block_id": recordId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["message"] == "User UnBlocked Successfully") {
          return true;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Ask for photos from user
  Future<PhotoPermission?> askForPhotosUser({required int userId}) async {
    try {
      var url = Uri.parse(ApiRoutes.askForGalleryPermissionApi);
      var body = {
        "user_id": userId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["message"] == "Requested") {
          return PhotoPermission.fromJson(data['data']);
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Add to interested users
  Future<UserDataModel?> addToInterestedUser({required int userId}) async {
    try {
      var url = Uri.parse(ApiRoutes.addUserToInterestedListApi);
      var body = {
        "favourite_user_id": userId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["message"] == "User added to favourite Successfully") {
          showShortToast(data['message'], bgColor: Colors.green);
          return UserDataModel.fromJson(data['user']['userData']);
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Remove user from interested users
  Future<bool?> removeUserFromInterested({required int userId}) async {
    try {
      var url = Uri.parse(ApiRoutes.removeUserFromInterestedListApi);
      var body = {
        "id": userId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["message"] == "User removed Successfully") {
          showShortToast(data['message'], bgColor: Colors.green);
          return true;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Unblock Blocked User
  Future<bool?> addProfileVisitRecord({required int visitingUserId}) async {
    try {
      var url = Uri.parse(ApiRoutes.addProfileVisitRecordApi);
      var body = {
        "visiting_profile_user_id": visitingUserId,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["message"] == "User UnBlocked Successfully") {
          return true;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Change User Settings
  Future<bool?> changeUserSettings({required String column, required int status}) async {
    try {
      var url = Uri.parse(ApiRoutes.changeUserSettingsApi);
      var body = {
        "column": column,
        "status": status
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["message"] == "Updated Successfully") {
          return true;
        } else {
          return false;
        }
      } else {
        //showErrorToast(data['message']);
        return false;
      }
    } catch (e) {
      return null;
    }
  }

  // Get Received Likes
  Future<List<UserDataModel>?> getReceivedLikes() async {
    try {
      var url = Uri.parse(ApiRoutes.getReceivedLikesApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["activity"] != null) {
          List<UserDataModel> parsedData = (data['activity'] as List)
              .map((item) {
            return UserDataModel(
              id: item['user_id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get Notifications list
  Future<List<NotificationModel>?> getNotificationsList() async {
    try {
      var url = Uri.parse(ApiRoutes.getNotificationsListApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["notifications"] != null) {
          List<NotificationModel> parsedData = (data['notifications'] as List)
              .map((item) {
            return NotificationModel.fromJson(item);
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Delete selected notifications
  Future<bool?> deleteSelectedNotifications({required List<int> notificationIds}) async {
    try {
      var url = Uri.parse(ApiRoutes.deleteSelectedNotificationsApi);
      var body = {
        "notificationIds": notificationIds,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  // Delete single notification
  Future<bool?> deleteSingleNotification({required int notificationId}) async {
    try {
      var url = Uri.parse("${ApiRoutes.deleteNotificationApi}/$notificationId");
      final response = await http.get(
        url,
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get My Likes
  Future<List<UserDataModel>?> getMyLikes() async {
    try {
      var url = Uri.parse(ApiRoutes.getMyLikesApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["activity"] != null) {
          List<UserDataModel> parsedData = (data['activity'] as List)
              .map((item) {
            return UserDataModel(
              id: item['user_id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get My Interested Users
  Future<List<UserDataModel>?> getInterestedUsers() async {
    try {
      var url = Uri.parse(ApiRoutes.getInterestedUsersListApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["users"] != null) {
          List<UserDataModel> parsedData = (data['users'] as List)
              .map((item) {
            return UserDataModel(
              id: item['favourite_user_id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get Gallery Permission Permitted Users
  Future<List<UserDataModel>?> getGalleryPermittedUsers() async {
    try {
      var url = Uri.parse(ApiRoutes.getGalleryPermittedUsersApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["permitted_users"] != null) {
          List<UserDataModel> parsedData = (data['permitted_users'] as List)
              .map((item) {
            return UserDataModel(
              id: item['user_id'],
              extraField: item['id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
              photosPermission: PhotoPermission(
                status: item['approved'],
                hasAsked: true,
              ),
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Accept gallery request from a user
  Future<bool?> acceptGalleryPermission(int requestId) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.acceptGalleryPermissionApi);
      final response = await http.post(
        url,
        body: json.encode({
          "id": requestId,
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  // Rejects gallery request from a user
  Future<bool?> rejectGalleryPermission(int requestId) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.rejectGalleryPermissionApi);
      final response = await http.post(
        url,
        body: json.encode({
          "id": requestId,
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  // Deletes gallery request from a user
  Future<bool?> deleteGalleryPermission(int requestId) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.deleteGalleryPermissionApi);
      final response = await http.post(
        url,
        body: json.encode({
          "id": requestId,
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  // Get Users Who Have Permitted Me To View Their Photos
  Future<List<UserDataModel>?> getUsersWhoPermittedMeGallery() async {
    try {
      var url = Uri.parse(ApiRoutes.getUsersWhoPermittedMeGalleryApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["permitted_users"] != null) {
          List<UserDataModel> parsedData = (data['permitted_users'] as List)
              .map((item) {
            return UserDataModel(
              id: item['id'],
              username: item['name'],
              profilePic: item['profile_pic'],
              createdAt: item['created_at'],
            );
          }).toList();
          return parsedData;
        } else {
          return null;
        }
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Update user online status
  Future<bool?> changeUserOnlineStatus(bool value) async {
    try {
      var url = Uri.parse(ApiRoutes.updateOnlineStatusApi);
      var body = {
        "status": changeTypeBoolToInt(value),
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      log("response $data");
      if (response.statusCode == 200) {
        int? result = data['result'];
        if(result != null) {
          bool updatedStatus = changeTypeIntToBool(result);
          UserModel? userData = LocalDataHelper().getUserAllData();
          userData?.user?.onlineStatus = updatedStatus;
          LocalDataHelper().saveUserAllData(userData!);
          return updatedStatus;
        } else {
          return null;
        }

      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Purchase Package
  Future<UserModel?> purchasePackage({
    required int packageId,
    required int purchasedAmount,
    required int discount,
    required int finalAmount,
  }) async {
    try {
      var url = Uri.parse(ApiRoutes.purchasePackageApi);
      var body = {
        "package_id": packageId,
        "purchased_amount": purchasedAmount,
        "discount": discount,
        "final_amount": finalAmount,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showShortToast(data['message'], bgColor: Colors.green);
        UserModel userModel = UserModel.fromJson(data['user']);
        LocalDataHelper().saveUserAllData(userModel);
        LocalDataHelper().saveUserTokenWithExpiry(
          userModel.accessToken.toString(),
          userModel.user!.id!,
        );
        return userModel;
      } else {
        //showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //Config Data
  Future<ConfigModel> getConfigData() async {
    final response = await _service.fetchJsonData(ApiRoutes.getAppConfigApi);
    return ConfigModel.fromJson(response);
  }

  Future<Map<String, dynamic>?> setupStripePaymentIntent({
    required String stripePrivateKey,
    required String customerId,
  }) async {
    try {
      var url = Uri.parse("https://api.stripe.com/v1/setup_intents");
      Map<String, dynamic> requestBody = {
        'automatic_payment_methods': {
          'enabled': true,
        },
        'customer': customerId,
      };
      var response = await http.post(url,
        body: json.encode(requestBody),
        headers: {
          'Authorization': 'Bearer $stripePrivateKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      var data = json.decode(response.body);
      if(response.statusCode == 200) {
        print("setup intent");
        print(data);
        return data;
      } else {
        return null;
      }
    } catch (err) {
      debugPrint('error ${err.toString()}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> createStripePaymentMethod({
    required String stripePrivateKey,
    required String customerId,
  }) async {
    try {
      var url = Uri.parse("https://api.stripe.com/v1/payment_methods");
      Map<String, dynamic> card = {
        "number": "4242424242424242",
        'exp_month': "12",
        "exp_year": "2034",
        "cvc": "314"
      };
      Map<String, dynamic> requestBody = {
        'card': json.encode(card),
      };
      var response = await http.post(url,
        body: json.encode(requestBody),
        headers: {
          'Authorization': 'Bearer $stripePrivateKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      var data = json.decode(response.body);
      if(response.statusCode == 200) {
        print("create payment method intent");
        print(data);
        return data;
      } else {
        return null;
      }
    } catch (err) {
      debugPrint('error ${err.toString()}');
      return null;
    }
  }

  Future<String?> createStripeCustomer({
    required String stripePrivateKey,
    required String name,
    required String email,
  }) async {
    try {
      var url = Uri.parse("https://api.stripe.com/v1/customers");
      var response = await http.post(url,
        body: {
          'name': name.toString(),
          'email': email.toString(),
        },
        headers: {
          'Authorization': 'Bearer $stripePrivateKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      var data = json.decode(response.body);
      if(response.statusCode == 200) {
        String? customerId = data['id'];
        if(customerId != null) {
          print(data);
          return customerId;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (err) {
      debugPrint('error ${err.toString()}');
      return null;
    }
  }

  Future<void> attachPaymentMethodToCustomer({
    required String customerId,
    required String paymentMethodId,
    required String stripePrivateKey,
  }) async {
    try {
      var url = Uri.parse("https://api.stripe.com/v1/payment_methods/$customerId/attach");
      Map<String, dynamic> requestBody = {
        'customer': customerId,
      };
      var response = await http.post(url,
        body: json.encode(requestBody),
        headers: {
          'Authorization': 'Bearer $stripePrivateKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      var data = json.decode(response.body);
      if(response.statusCode == 200) {
        print("attaching payment method $data");
      }
    } catch (err) {
      debugPrint('error ${err.toString()}');
    }
  }

  // Contact us
  Future<bool?> contactMessage({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String message,
  }) async {
    try {
      var url = Uri.parse(ApiRoutes.contactUsApi);
      var body = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phone,
        "message": message,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        showErrorToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get Referred User
  Future<List<UserDataModel>?> getReferredUser() async {
    try {
      var url = Uri.parse(ApiRoutes.getReferralUsersListApi);
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["referrals"] != null) {
          List<UserDataModel> parsedData = (data['referrals'] as List).map((item) {
            return UserDataModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        // Handle non-200 status code, log or throw an exception if needed.
        print("Failed to fetch data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Log or handle the exception.
      print("Error: $e");
      return null;
    }
  }

  // Get Interests list
  Future<List<InterestModel>?> getInterestsList() async {
    try {
      var url = Uri.parse(ApiRoutes.getInterestsListApi);
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        log("response $data");
        if (data["newInterests"] != null) {
          List<InterestModel> parsedData = (data['newInterests'] as List).map((item) {
            return InterestModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        // Handle non-200 status code, log or throw an exception if needed.
        print("Failed to fetch data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Log or handle the exception.
      print("Error: $e");
      return null;
    }
  }

  // Save user interests
  Future<bool?> saveUserInterests({
    required List<int?> interestIDS,
  }) async {
    try {
      var url = Uri.parse(ApiRoutes.saveInterestsListApi);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({'interestIds': interestIDS}),
      );
      var data = json.decode(response.body);
      log("interest ${interestIDS.toString()} response $data");
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Add a user to ignore list
  Future<UserDataModel?> addUserToIgnoreList(int userId) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.addUserToIgnoredListApi);
      final response = await http.post(
        url,
        body: json.encode({
          "ignored_user_id": userId
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      print("response $data");
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return UserDataModel.fromJson(data['user']);
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return null;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return null;
    }
  }

  // Remove a user from ignore list
  Future<bool?> removeUserFromIgnoreList(int userId) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.removeUserFromIgnoredListApi);
      final response = await http.post(
        url,
        body: json.encode({
          "id": userId,
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  // Report user
  Future<bool?> reportUser(int userId, String reason) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.reportUserApi);
      final response = await http.post(
        url,
        body: json.encode({
          "user_id": userId,
          "reason": reason,
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  // Wife Registration
  Future<UserDataModel?> wifeRegistration({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String country,
    required String state,
    required String city,
    required String dob,
    required String latitude,
    required String longitude,
    required String religion,
    required String education,
    required String doesShePray,
    required Map<dynamic, dynamic> appearance,
    required String specifications,
    required String ethnicity,
    String? children,
    required String? profilePic,
  }) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.wifeRegistrationApi);
      var body = {
        "first_name": firstName,
        "last_name": lastName,
        "username": userName,
        "email": email,
        "password": password,
        "profile_pic": profilePic,
        "education": education,
        "country": country,
        "state": state,
        "city": city,
        "dob": dob,
        "religion": religion,
        "prayer": doesShePray,
        "my_specification": specifications,
        "ethnicity": ethnicity,
        "appearance": appearance,
      };
      final response = await http.post(
        url,
        body: json.encode(body),
        headers: headers,
      );
      var data = json.decode(response.body);
      print("wife reg response $data");
      if (response.statusCode == 200) {
        if(data['message'] == "Wife created") {
          if(kIsWeb) {
            showCustomSnackBar(data['message']);
          } else {
            showShortToast(data['message'], bgColor: Colors.green);
          }
          Get.back();
          UserDataModel userDataModel = UserDataModel.fromJson(data['user']);
          return userDataModel;
        } else {
          return null;
        }
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return null;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return null;
    }
  }

  // Create support ticket
  Future<bool?> createSupportTicket({required TicketModel ticket}) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.createSupportTicketApi);
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": ticket.title,
            "message": ticket.message,
            "file": ticket.file
          }
        ),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return null;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return null;
    }
  }

  // Get Support tickets
  Future<List<TicketModel>?> getUsersSupportTickets() async {
    try {
      var url = Uri.parse(ApiRoutes.getUserSupportTicketsApi);
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data["tickets"] != null) {
          List<TicketModel> parsedData = (data['tickets'] as List).map((item) {
            return TicketModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  // Get Ticket answers
  Future<List<TicketModel>?> getTicketsAnswers(int ticketId) async {
    try {
      var url = Uri.parse(ApiRoutes.getSupportTicketAnswersApi);
      final response = await http.post(
        url,
        body: json.encode({"ticket_id": ticketId}),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data["answers"] != null) {
          List<TicketModel> parsedData = (data['answers'] as List).map((item) {
            return TicketModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Answer ticket
  Future<List<TicketModel>?> sendAnswerToTicket({int? ticketId, required String message}) async {
    try {
      var url = Uri.parse(ApiRoutes.answerTicketApi);
      final response = await http.post(
        url,
        body: json.encode({
          "ticket_id": ticketId,
          "message": message,
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if(data["conversation"] != null) {
          List<TicketModel> parsedData = (data['conversation'] as List).map((item) {
            return TicketModel.fromJson(item);
          }).toList();

          return parsedData;
        } else {
          return null;
        }
      } else {
        showErrorToast(data['message']);
        return null;
      }
    } catch (e) {
      return null;
    }
  }



  // Get Agora Token For call
  Future<String?> getRctToken(String channelId, String agoraUid) async {
    try {
      var url = Uri.parse("${ApiRoutes.agoraTokenServerApi}access_token?channelName=$channelId");
      final response = await http.get(url,headers: headers);
      var data = json.decode(response.body);
      print("wife reg response $data");
      if (response.statusCode == 200) {
        return data['token'];
      } else {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return null;
      }
    } catch (e) {
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return null;
    }
  }

  // Dial Call to user
  Future<bool?> dialCall({
    required int userId,
    required String channelId,
    required String agoraUid,
    required bool isVideoCall,
  }) async {
    try {
      Dialogs.showLoadingDialog();
      var url = Uri.parse(ApiRoutes.dialCallApi);
      final response = await http.post(
        url,
        body: json.encode({
          "user_id": userId,
          "channel_id": channelId,
          "agora_uid": agoraUid,
          "is_video_call": isVideoCall,
        }),
        headers: headers,
      );
      var data = json.decode(response.body);
      print("report response $data");
      if (response.statusCode == 200) {
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showShortToast(data['message'], bgColor: Colors.green);
        }
        Get.back();
        return true;
      } else {
        Get.back();
        if(kIsWeb) {
          showCustomSnackBar(data['message']);
        } else {
          showErrorToast(data["message"]);
        }
        return false;
      }
    } catch (e) {
      Get.back();
      if(kIsWeb) {
        showCustomSnackBar("An error occurred: $e");
      } else {
        showErrorToast("An error occurred: $e");
      }
      return false;
    }
  }

  //LogOut
  Future logOut() async {
    try {
      var url = Uri.parse(ApiRoutes.userLogoutApi);
      var body = {
        "user_id": LocalDataHelper().getUserId().toString(),
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      var data = json.decode(response.body);
      log("logout response $data");
      if (response.statusCode == 200) {
        showShortToast(data['message']);
        return true;
      } else {
        showErrorToast(data['message']);
        return false;
      }
    } catch (e) {
      return null;
    }
  }
}
