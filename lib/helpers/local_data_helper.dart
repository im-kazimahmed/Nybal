import 'package:get_storage/get_storage.dart';
import 'package:nybal/models/country_model.dart';
import '../models/config_model.dart';
import '../models/religion_model.dart';
import '../models/user_model.dart';


class LocalDataHelper {
  var box = GetStorage();

  Future<void> saveUserPermissionLimit(String permissionName, int limit) async {
    try {
      await box.write(permissionName, limit);
    } catch (e) {
      print('Error saving permission limit: $e');
    }
  }

  int? getUserPermissionLimit(String permissionName) {
    try {
      var permissionLimit = box.read(permissionName);
      return permissionLimit;
    } catch (e) {
      print('Error reading permission limit: $e');
      return null;
    }
  }

  saveUserAllData(UserModel userDataModel) async {
    await box.write('userModel', userDataModel.toJson());
  }

  UserModel? getUserAllData() {
    var userDataModel = box.read('userModel');
    return userDataModel != null ? UserModel.fromJson(userDataModel) : null;
  }

  saveAllReligions(List<ReligionModel> religionModel) async {
    await box.write('religions', religionModel.toList());
  }

  saveAllCountries(List<CountryModel> countryModel) async {
    await box.write('countries', countryModel.toList());
  }

  saveAllStatesByCountry(String countryId, List<StateModel> states) async {
    await box.write('statesOf$countryId', states.toList());
  }

  saveAllCitiesByState(String stateId, List<CityModel> cities) async {
    await box.write('citiesOf$stateId', cities.toList());
  }

  List<CountryModel>? getAllCountries() {
    try {
      List<CountryModel>? countries = box.read('countries');
      return countries;
    } catch (e) { return null; }
  }

  List<ReligionModel>? getAllReligions() {
    try {
      List<ReligionModel>? religions = box.read('religions');
      return religions;
    } catch (e) { return null; }
  }

  List<StateModel>? getStatesByCountry(String countryId) {
    try {
      List<StateModel>? states = box.read('statesOf$countryId');
      return states;
    } catch (e) { return null; }
  }

  saveAllSubReligionsByReligion(String religionId, List<ReligionModel> religions) async {
    await box.write('subReligionsOf$religionId', religions.toList());
  }

  List<ReligionModel>? getSubReligionsByReligion(String religionId) {
    try {
      List<ReligionModel>? religions = box.read('subReligionsOf$religionId');
      return religions;
    } catch (e) { return null; }
  }

  List<CityModel>? getCitiesByState(String stateId) {
    try {
      List<CityModel>? cities = box.read('citiesOf$stateId');
      return cities;
    } catch (e) { return null; }
  }

  void saveUserTokenWithExpiry(String userToken, int userId) async {
    DateTime now = DateTime.now();
    DateTime expiryTime = now.add(const Duration(hours: 24));

    Map<String, dynamic> userData = {
      'user_id': userId,
      'userToken': userToken,
      'expiryTime': expiryTime.toUtc().toString(),
    };

    await box.write('userTokenData', userData);
  }

  void saveUserTokenIncognito(String userToken, int userId) async {
    DateTime now = DateTime.now();
    DateTime expiryTime = now.add(const Duration(minutes: 1));

    Map<String, dynamic> userData = {
      'user_id': userId,
      'userToken': userToken,
      'expiryTime': expiryTime.toUtc().toString(),
    };

    await box.write('userTokenData', userData);
  }

  String? getUserToken() {
    Map<String, dynamic>? userData = box.read('userTokenData');
    if (userData != null) {
      DateTime expiryTime = DateTime.parse(userData['expiryTime']);
      if (DateTime.now().isBefore(expiryTime)) {
        return userData['userToken'];
      }
    }
    return null;
  }

  int? getUserId() {
    Map<String, dynamic>? userData = box.read('userTokenData');
    if (userData != null) {
      DateTime expiryTime = DateTime.parse(userData['expiryTime']);
      if (DateTime.now().isBefore(expiryTime)) {
        return userData['user_id'];
      }
    }
    return null;
  }

  //Home Data
  // void saveHomeContent(HomeDataModel data) {
  //   box.write("home_content", data.toJson());
  // }

  // HomeDataModel? getHomeData() {
  //   Map<String, dynamic>? stringData = box.read("home_content");
  //   if (stringData != null) {
  //     HomeDataModel data = HomeDataModel.fromJson(stringData);
  //     return data;
  //   }
  //   return null;
  // }

  Future<void> saveConfigData(ConfigModel data) async {
    await box.write("config_model", data.toJson());
  }

  ConfigModel getConfigData() {
    return ConfigModel.fromJson(box.read("config_model"));
  }

  // Future<ConfigModel> getConfigFuture() async {
  //   return ConfigModel.fromJson(box.read("config_model"));
  // }

  //Language code save/get
  void saveLanguageServer(String langCode) {
    box.write('langCode', langCode);
  }

  getLangCode() {
    var getData = box.read("langCode");
    return getData;
  }

  // Saving a value if session is expired or not
  void saveIsSessionExpired(bool isExpired) {
    box.write('isSessionExpired', isExpired);
  }

  getIsSessionExpired() {
    var getData = box.read("isSessionExpired");
    return getData;
  }

  // Remember email and password
  void saveRememberMail(String mail) {
    box.write('mail', mail);
  }

  getRememberMail() {
    var getData = box.read("mail");
    return getData;
  }

  void saveIncomingAgoraChannelId(String? channelId, String? agoraUid, String? isVideoCall) async {
    DateTime now = DateTime.now();
    DateTime expiryTime = now.add(const Duration(minutes: 1));

    Map<String, dynamic> userData = {
      'channel_id': channelId,
      'agora_uid': agoraUid,
      'is_video_call': isVideoCall,
      'expiryTime': expiryTime.toUtc().toString(),
    };

    await box.write('channelData', userData);
  }

  Map<String, dynamic>? getUserIncomingChannelId() {
    try {
      Map<String, dynamic>? userData = box.read('channelData');
      if (userData != null) {
        DateTime expiryTime = DateTime.parse(userData['expiryTime']);
        if (DateTime.now().isBefore(expiryTime)) {
          return userData;
        }
      }
    } catch(e) {}
    return null;
  }

  void saveRememberPass(String pass) {
    box.write('pass', pass);
  }

  getRememberPass() {
    var getData = box.read("pass");
    return getData;
  }

  // Future saveUser(ProfileDataModel user) async {
  //   await box.write('user', user);
  // }

  void saveForgotPasswordCode(String code) async {
    await box.write('code', code);
    //_profileContentController.update();
  }

  String? getForgotPasswordCode() {
    String? getData = box.read("code");
    return getData;
  }
}
