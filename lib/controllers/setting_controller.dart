import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/payment_controller.dart';
import 'package:nybal/models/package_model.dart';
import '../helpers/local_data_helper.dart';
import '../models/config_model.dart';
import '../models/country_model.dart';
import '../models/gender_model.dart';
import '../repository/repository.dart';
import 'language_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

class SettingController extends GetxController {
  final LanguageController langController = Get.find<LanguageController>();
  var countriesList = <CountryModel>[].obs;
  var gendersList = <GenderModel>[].obs;
  var educationsList = <Educations>[].obs;

  RxString discountOnSubscription = RxString("");
  RxString discountOnSpotlight = RxString("");
  var packages = <UserPackage>[].obs;
  AppConfig? appConfig;
  late Timer timer;
  RxInt hours = RxInt(0);
  RxInt minutes = RxInt(45);
  RxInt seconds = RxInt(30);
  RxBool specialPackageAvailable = RxBool(false);

  // @override
  // void onInit() {
  //   getCountriesList();
  //   super.onInit();
  // }


  Future getCountriesList() async {
    var data = await Repository().getCountriesList();
    if(data != null) {
      countriesList.value = data;
    } else {
      var countries = LocalDataHelper().getAllCountries();
      if(countries != null) {
        countriesList.value = countries;
      }
    }
  }

  Future<List<UserPackage>?> getPackagesList() async {
    List<UserPackage>? data = await Repository().getPackagesList();
    if(data != null) {
      packages.value = data;
      startTimer();
      return data;
    } else {
      return null;
    }
  }

  Future<String> getIpAddress() async {
    if (kIsWeb) {
      try {
        final response = await http.get(Uri.parse('https://api64.ipify.org?format=json'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final ipAddress = data['ip'];
          return ipAddress;
        } else { return "192.168"; }
      } catch (e) {
        print('Error getting IP address: $e');
      }
      return '192.168';
    } else {
      String ipAddress = "";
      try {
        for (var interface in await NetworkInterface.list()) {
          for (var add in interface.addresses) {
            ipAddress = add.address;
          }
        }
      } catch (e) {
        ipAddress = "192.168";
      }
      return ipAddress;
    }
  }

  Future<String> getDeviceId() async {
    if(kIsWeb) {
      String userAgent = html.window.navigator.userAgent;
      String ipAddress = await getIpAddress();
      String webIdentifier = '$ipAddress';
      print('Banning user with web identifier: $webIdentifier');
      return webIdentifier;
    } else {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      String deviceId = "${allInfo['id']}";
      return deviceId;
    }
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // String deviceId = "";
    //
    // try {
    //   if (Platform.isAndroid) {
    //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //     deviceId = androidInfo.id;
    //   } else if (Platform.isIOS) {
    //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //     deviceId = iosInfo.identifierForVendor!;
    //   }
    // } catch (e) {
    //   print('Error getting device ID: $e');
    // }
    //
    // print('Device ID: $deviceId');
  }

  void startTimer() {
    try {
      if(packages.isNotEmpty) {
        UserPackage? specialPackage = packages.firstWhere(
              (package) => package.isSpecialPackage == true,
          orElse: () => UserPackage(),
        );

        if (specialPackage.createdAt != null) {
          specialPackageAvailable(true);
          DateTime createdAt = DateTime.parse(specialPackage.createdAt!);
          DateTime now = DateTime.now();

          if (createdAt.isAfter(now)) {
            Duration timeDifference = createdAt.difference(now);

            // Calculate remaining hours, minutes, and seconds
            int remainingHours = (timeDifference.inHours).clamp(0, 99);
            int remainingMinutes = (timeDifference.inMinutes % 60).clamp(0, 59);
            int remainingSeconds = (timeDifference.inSeconds % 60).clamp(0, 59);

            hours.value = remainingHours;
            minutes.value = remainingMinutes;
            seconds.value = remainingSeconds;

            Timer.periodic(const Duration(seconds: 1), (timer) {
              if (hours.value == 0 && minutes.value == 0 && seconds.value == 0) {
                specialPackageAvailable(false);
                timer.cancel();
                update();
              } else if (seconds.value == 0) {
                if (minutes.value > 0) {
                  minutes.value--;
                  seconds.value = 59;
                } else {
                  if (hours.value > 0) {
                    hours.value--;
                    minutes.value = 59;
                    seconds.value = 59;
                  }
                }
              } else {
                seconds.value--;
              }
            });
          } else {
            specialPackageAvailable(false);
            log("Special package creation time is not in the future");
          }
        } else {
          specialPackageAvailable(false);
          log("No special package found");
        }
      }
    } catch (e) {
      log("exception $e");
    }
  }

  // void startTimer() {
  //   if(packages.isNotEmpty) {
  //     UserPackage? specialPackage = packages.firstWhere((package) => package.isSpecialPackage == true);
  //     log("special package found ${specialPackage.toJson()}");
  //   }
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (hours.value == 0 && minutes.value == 0 && seconds.value == 0) {
  //       hours.value = 2;
  //       minutes.value = 45;
  //       seconds.value = 30;
  //     } else if (seconds.value == 0) {
  //       if (minutes.value > 0) {
  //         minutes.value--;
  //         seconds.value = 59;
  //       } else {
  //         if (hours.value > 0) {
  //           hours.value--;
  //           minutes.value = 59;
  //           seconds.value = 59;
  //         }
  //       }
  //     } else {
  //       seconds.value--;
  //     }
  //   });
  //
  // }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}