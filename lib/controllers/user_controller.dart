import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/models/interest_model.dart';
import 'package:nybal/utils/functions.dart';
import 'package:nybal/widgets/dialogs.dart';
import 'package:nybal/widgets/my_date_util.dart';
import '../Widgets/theme_data.dart';
import '../helpers/local_data_helper.dart';
import '../models/config_model.dart';
import '../models/conversation_model.dart';
import '../models/country_model.dart';
import '../models/notification_model.dart';
import '../models/photo_model.dart';
import '../models/user_model.dart';
import '../repository/repository.dart';
import '../utils/app_tags.dart';
import '../utils/validators.dart';
import 'chat_controller.dart';
import 'setting_controller.dart';

class UserController extends GetxController {
  // Authenticated User's Data
  late UserModel userData;
  RxBool isEditMode = RxBool(false);
  final settingController = Get.find<SettingController>();
  var userConversations = <ConversationModel>[].obs;
  var userPhotos = <PhotoModel>[].obs;
  var usersWhoVisitedProfile = <UserDataModel>[].obs;
  var galleryPermittedUsers = <UserDataModel>[].obs;
  var whoPermittedMeGalleryUsers = <UserDataModel>[].obs;
  var blockedUsers = <UserDataModel>[].obs;
  var ignoredUsers = <UserDataModel>[].obs;
  var receivedLikes = <UserDataModel>[].obs;
  var myLikes = <UserDataModel>[].obs;
  var myNotificationsList = <NotificationModel>[].obs;
  var selectedInterests = <InterestModel>[].obs;

  // Selected Notifications
  List<int> selectedNotifications = List.empty(growable: true);
  List<int> selectedNotificationIds = List.empty(growable: true);

  var filteredUsersList = <UserDataModel>[].obs;
  var usersList = <UserDataModel>[].obs;
  var spotlightUsers = <UserDataModel>[].obs;
  var newMembers = <UserDataModel>[].obs;
  var favouriteList = <UserDataModel>[].obs;
  var selectedUser = UserDataModel().obs;
  var selectedPhotoRequestUser = UserDataModel().obs;
  RxBool sideBarMenusExpanded = RxBool(false);
  RxInt selectedPhotosPageIndex = RxInt(0);
  RxInt openSelectUserReportMenuIndex = RxInt(-1);
  RxInt openSelectUserPhotoMenuIndex = RxInt(-1);
  RxBool isLoading = RxBool(false);

  // Filter Page
  RangeValues currentAgeRangeValues = const RangeValues(0, 0);
  RxBool isFiltering = RxBool(false);
  List<Map<String, String>> selectedAdvancedFilters = [];
  List<Map<String, String>> advancedFilters = [
    {'name': '160 cm (5`4")', 'image': 'assets/images/height.png'},
    {'name': "Never Married", 'image': 'assets/images/ring.png'},
    {'name': "Doesn't have children", 'image': 'assets/images/kid.png'},
    {'name': 'Marriage within a year', 'image': 'assets/images/calender.png'},
    {'name': "Won't move abroad", 'image': 'assets/images/airplan.png'},
  ];


  CountryModel? selectedCountry;

  // Contact Us Page Fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  // User Profile Page
  TextEditingController reportReasonController = TextEditingController();

  // On Filter Change
  void onFilterChange({
    required String filterName,
    required String filterValue,
    required List<UserDataModel> originalUsersList,
    required void Function(List<UserDataModel>?) onFilteredListChanged,
  }) {
    List<UserDataModel> filteredList = List.from(originalUsersList);

    if (filterName == "gender") {
      applyGenderFilter(filterValue, filteredList);
    } else if (filterName == "country") {
      print("on country filter");
      applyCountryFilter(filterValue, filteredList);
    }

    onFilteredListChanged(filteredList);
    update();
  }

  void applyGenderFilter(String filterValue, List<UserDataModel> filteredList) {
    if (filterValue == "All") {
      return;
    } else if (filterValue == "Male" || filterValue == "Female") {
      filteredList.retainWhere((user) =>
      user.gender?.toLowerCase() == filterValue.toLowerCase());
    }
  }

  void applyCountryFilter(String filterValue, List<UserDataModel> filteredList) {
    filteredList.retainWhere((user) =>
    user.country?.toLowerCase() == filterValue.toLowerCase());
  }

  void selectOrRemoveAdvancedFilter(Map<String, String> record) {
    bool recordExists = selectedAdvancedFilters.any((filter) => filter['name'] == record['name']);
    if (recordExists) {
      selectedAdvancedFilters.removeWhere((filter) => filter['name'] == record['name']);
    } else {
      selectedAdvancedFilters.add(record);
    }
    update();
  }

  // Marry Interested Users Page
  var marryInterestedUsers = <UserDataModel>[].obs;
  // var filteredMarryInterestedUsers = <UserDataModel>[].obs;
  String currentGenderFilter = "All";

  // Get Members Who wish to marry
  Future<List<UserDataModel>?> getWhoWishToMarryMembers() async {
    List<UserDataModel>? users = await Repository().getUsersWhoWishToMarry();
    if(users != null) {
      marryInterestedUsers.value = users;
      return users;
    } else {
      return null;
    }
  }

  filterMarryList({required List<UserDataModel>? filtered, required String filterValue}) {
    if(filtered != null) {
      filteredUsersList.value = filtered;
    }
    currentGenderFilter = filterValue;
  }


  // Drop Down Country Change
  onCountryChange(CountryModel option) {
    selectedCountry = option;
    isFiltering(true);
    applyFilters(
      filterName: "country",
      filterValue: option.name.toString(),
    );
  }

  // On User's Report Menu Change
  onUserReportMenuChange(int value) {
    openSelectUserReportMenuIndex.value = value;
    update();
  }

  // On Photos Page User's Menu Change
  onUserPhotoMenuChange(int value) {
    openSelectUserPhotoMenuIndex.value = value;
    update();
  }

  void handleUserTap(UserDataModel? user) {
    selectedPhotoRequestUser.value = user!;
    update();
  }


  bool isPermissionEnabled({required String permissionName}) {
    try {
      String permissionNameToCheck = permissionName;
      var permission = userData.packagePermissions?.firstWhere(
            (perm) => perm.permissionName == permissionNameToCheck,
      );

      if (permission != null && permission.permissionAllow == true) {
        print("The '$permissionNameToCheck' permission is enabled.");
        return true;
      } else {
        print("The '$permissionNameToCheck' permission is not enabled.");
        return false;
      }
    } catch (e) {
     return false;
    }
  }

  Map<String, dynamic> checkSubPermissions(String permissionName) {
    Map<String, dynamic> result = {};

    try {
      var permission = userData.packagePermissions?.firstWhere(
            (perm) => perm.permissionName == permissionName,
      );

      if (permission != null && permission.subPermissions != null) {
        var subPermissions = permission.subPermissions;
        print("sub permissions ${subPermissions?.toJson()}");
        // Check if per_gender is enabled
        if (subPermissions != null && subPermissions.perGender != null) {
          var genderPermissions = subPermissions.perGender;
          print("gender permission ${genderPermissions?.toJson()}");
          // Check if male is enabled
          if (genderPermissions?.male != null) {
            result['isMaleEnabled'] = genderPermissions?.male;

            if (result['isMaleEnabled'] == true &&
                genderPermissions!.isMaleMapWithLimit()) {
              result['male_limit'] = genderPermissions.getMaleLimit();
            }
          }

          // Check if female is enabled
          if (genderPermissions?.female != null) {
            result['isFemaleEnabled'] = genderPermissions?.female;

            if (result['isFemaleEnabled'] == true &&
                genderPermissions!.isFemaleMapWithLimit()) {
              // Check the limit for female
              result['female_limit'] = genderPermissions.getFemaleLimit();
            }
          }
        }
      }
    } catch (e) {
      print('Error checking sub-permissions: $e');
    }

    return result;
  }


  int? getPermissionLimitEnabled({required String permissionName}) {
    String permissionNameToCheck = permissionName;
    var permission = userData.packagePermissions?.firstWhere(
          (perm) => perm.permissionName == permissionNameToCheck,
    );

    if (permission != null && permission.permissionLimit != null) {
      return permission.permissionLimit;
    } else {
      return null;
    }
  }

  int? getPermissionLimit(String permissionName, String formattedName) {
    int? limit = getPermissionLimitEnabled(permissionName: permissionName);

    if (limit != null) {
      int? sentLimit = LocalDataHelper().getUserPermissionLimit(permissionName);
      if (sentLimit == null) {
        // This is the first time sending a message, set the limit to the initial value
        log("First time sending message, initial limit is $limit");
        LocalDataHelper().saveUserPermissionLimit(permissionName, 0);
        return limit;
      } else if (sentLimit < limit) {
        int newSentLimit = sentLimit + 1;
        log("User can send message, current limit is $newSentLimit");
        LocalDataHelper().saveUserPermissionLimit(permissionName, newSentLimit);
        return newSentLimit;
      } else {
        // The user has reached the limit
        log("limit $limit sentLimit $sentLimit");
        showShortToast("You have reached the limit of $formattedName");
        return sentLimit;
      }
    } else {
      return null;
    }
  }

  void isSubPermissionEnabled({required String permissionName}) {
    String permissionNameToCheck = permissionName;

    // Finds the permission from user data by permission name
    var permission = userData.packagePermissions?.firstWhere(
        (perm) => perm.permissionName == permissionNameToCheck,
    );

    // Check if the permission exists and is allowed
    if (permission != null && permission.permissionAllow == true) {
      log("'$permissionNameToCheck' is enabled");

      // Check if there are sub permissions
      var subPermissions = permission.subPermissions;

      if (subPermissions != null) {
        // Check "subscribed_on" in sub permissions
        bool isSubscribedOnEnabled = subPermissions.subscribedOn == true;

        // Check "per_country" in sub permissions
        bool isPerCountryEnabled = subPermissions.perCountry == true;

        // Check "per_gender" in sub permissions
        var perGender = subPermissions.perGender;

        if (perGender != null) {
          // Check if "male" in per_gender is true
          bool isMaleEnabled = perGender.male == true;
          bool isFemaleEnabled = perGender.female == true;

          if(isFemaleEnabled != true && isFemaleEnabled != false) {
            // Check if "female" in per_gender is an object with a "limit" property
            bool isFemaleEnabledWithLimit = perGender.female is Map<String, dynamic> &&
                perGender.female.containsKey("limit") &&
                perGender.female["limit"] is int;

            if (isFemaleEnabledWithLimit) {
              int femaleLimit = perGender.female["limit"];
              log("Limit is enabled for female with a limit of $femaleLimit");
            }
          } else {
            if (isFemaleEnabled) {
              log("Female is enabled");
            }
          }

          if(isMaleEnabled != true && isMaleEnabled != false) {
            // Check if "Male" in per_gender is an object with a "limit" property
            bool isMaleEnabledWithLimit = perGender.male is Map<String, dynamic> &&
                perGender.male.containsKey("limit") &&
                perGender.male["limit"] is int;

            if (isMaleEnabledWithLimit) {
              int maleLimit = perGender.male["limit"];
              log("Limit is enabled for male with a limit of $maleLimit");
            }
          } else {
            if (isMaleEnabled) {
              log("Male is enabled");
            }
          }
        }

        if (isSubscribedOnEnabled) {
          log("Subscribed On is enabled");
        }

        if (isPerCountryEnabled) {
          log("Per Country is enabled");
        }
      } else {
        log("There are no sub permissions for '$permissionNameToCheck'.");
      }
    } else {
      log("permission is not enabled.");
    }
  }

  Future<List<UserDataModel>?> getAllUsers() async {
    List<UserDataModel>? users = await Repository().getPotentialMatches();
    if(users != null) {
      usersList.value = users;
      filteredUsersList.value = users;
      return users;
    } else {
      return null;
    }
  }

  Future<List<UserDataModel>?> getSpotlightUsers() async {
    List<UserDataModel>? users = await Repository().getSpotlightUsers();
    if(users != null) {
      spotlightUsers.value = users;
      return users;
    } else {
      return null;
    }
  }

  // Get New Members
  Future<List<UserDataModel>?> getNewMembers() async {
    List<UserDataModel>? users = await Repository().getPotentialMatches();
    if(users != null) {
      newMembers.value = users;
      return users;
    } else {
      return null;
    }
  }

  Future<List<ConversationModel>?> getAllUserConversations() async {
    List<ConversationModel>? conversations = await Repository().getUserConversations();
    if(conversations != null) {
      conversations.sort((a, b) {
        if (a.latestMessageDate == null && b.latestMessageDate == null) {
          return 0;
        } else if (a.latestMessageDate == null) {
          return 1;
        } else if (b.latestMessageDate == null) {
          return -1;
        } else {
          return b.latestMessageDate!.compareTo(a.latestMessageDate!);
        }
      });
      userConversations.value = conversations;
      update();
      return conversations;
    } else {
      return null;
    }
  }

  bool isProfileComplete() {
    UserDataModel user = userData.user!;
    return user.country != null && user.country != "" && user.subReligion != null && user.subReligion != "";
    // return user.profilePic != null && user.profilePic != "";
  }

  bool isUserEmailVerified() {
    UserDataModel user = userData.user!;
    AppConfig? config = settingController.appConfig;
    if(config != null && config.emailVerificationSystem == true) {
      return user.emailVerify != null && user.emailVerify != false;
    } else {
      return true;
    }
  }

  void applyFilters({
    required String filterName,
    required String filterValue,
    RangeValues? ageValues,
  }) {
    List<UserDataModel> filteredList = List.from(usersList);

    if (filterName == "country") {
      filteredList = filteredList
          .where((user) => user.country == filterValue)
          .toList();
    }

    if (filterName == "age" && ageValues != null) {
      final minAge = ageValues.start;
      final maxAge = ageValues.end;
      filteredList = filteredList.where((user) {
        final userAge = MyDateUtil.calculateAge(user.dateOfBirth);
        return userAge != null && userAge >= minAge && userAge <= maxAge;
      }).toList();
    }

    filteredUsersList.value = filteredList;
    update();
  }

  onAgeChange(RangeValues values) {
    currentAgeRangeValues = values;
    isFiltering(true);
    update();
  }

  resetFiltering() {
    isFiltering(false);
    currentAgeRangeValues = const RangeValues(0, 0);
    selectedCountry = CountryModel(
      name: AppTags.allCountriesHint.tr,
    );
    filteredUsersList.value = List.from(usersList);
    update();
  }

  onSideBarMenuExpanded() {
    sideBarMenusExpanded.value = !sideBarMenusExpanded.value;
    update();
  }

  // My Photos Page Menus Index Handle
  onPhotosPageIndexHandle(int index) {
    selectedPhotosPageIndex.value = index;
    update();
  }

  // Toggle Profile Edit Mode
  onEditProfileChanged() {
    isEditMode.value = !isEditMode.value;
    update();
  }

  // Change User Settings (On) (Off)
  void onUserSettingChanged({required String settingName, required bool value}) async {
    bool? result = await Repository().changeUserSettings(
      column: settingName,
      status: changeTypeBoolToInt(value)
    );
    if(result != null) {
      if(settingName == "user_marry_interest") {
        userData.user?.isMarryInterested = value;
      }
      if(settingName == "activated_notifications") {
        userData.user?.activateNotifications = value;
      }
      if(settingName == "email_notification") {
        userData.user?.emailNotificationsEnabled = value;
      }
      if(settingName == "receive_new_messages") {
        userData.user?.receiveNewMessagesEnabled = value;
      }
      update();
    }
  }

  Future<List<PhotoModel>?> getAllUserPhotos() async {
    isLoading(true);
    List<PhotoModel>? photos = await Repository().getUserPhotos(userData.user!.id!);
    if(photos != null) {
      userPhotos.value = photos;
      update();
      isLoading(false);
      return photos;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<bool?> deleteGalleryPhoto(int recordId) async {
    isLoading(true);
    bool? result = await Repository().deleteGalleryPhoto(
      photoId: recordId,
    );
    if(result != null) {
      update();
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<bool?> grantGalleryPermission(int userId) async {
    isLoading(true);
    bool? result = await Repository().grantGalleryPermissionToUser(
      userId: userId,
    );
    if(result != null) {
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<void> selectUserToGrantGalleryPermission () async {
    int? selectedUserId;
    await Get.defaultDialog(
      title: "Select User",
      middleText: "Select user to grant gallery permission",
      backgroundColor: AppColors.pinkButton,
      titleStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      middleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      content: Container(
        height: Get.height / 1.5,
        width: kIsWeb ? Get.width / 2: Get.width,
        decoration: BoxDecoration(
          color: mainClr
        ),
        child: ListView.builder(
          itemCount: usersList.length,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: "${usersList[index].profilePic}",
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                            placeholder: (context, url) {
                              return const CircleAvatar(
                                child: Icon(
                                  CupertinoIcons.person,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              );
                            },
                          ),
                        ),
                      ),
                      GetBuilder<ChatController>(builder: (ChatController chatController) {
                        try {
                          if(chatController.isUserOnline(usersList[index].id!)) {
                            return Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                ),
                                padding: const EdgeInsets.all(4.0),
                              ),
                            );
                          }
                        }
                        catch (e) { }
                        return Container();
                      }),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${usersList[index].firstName} ${usersList[index].lastName}",
                          style: const TextStyle(),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      selectedUserId = usersList[index].id;
                      Get.back();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF27B2CC),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: const Text(
                        "Select",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
      radius: 30,
      onConfirm: () {
        // grantGalleryPermission(8);
        Get.back();
      },
      buttonColor: Colors.white,
      confirmTextColor: AppColors.pinkButton,
    );
    if(selectedUserId != null) {
      grantGalleryPermission(selectedUserId!);
    }
  }

  // Get Users Who Can See My Photos
  Future<List<UserDataModel>?> getGalleryPermittedUsers() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getGalleryPermittedUsers();
    if(users != null) {
      galleryPermittedUsers.value = users;
      isLoading(false);
      update();
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  // Get Users Who Have Permitted Me To View Their Photos
  Future<List<UserDataModel>?> getUsersWhoPermittedMeGallery() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getUsersWhoPermittedMeGallery();
    if(users != null) {
      whoPermittedMeGalleryUsers.value = users;
      isLoading(false);
      update();
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<List<UserDataModel>?> getUsersWhoVisitedMyProfile() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getWhoVisitedMyProfile();
    if(users != null) {
      usersWhoVisitedProfile.value = users;
      update();
      isLoading(false);
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  // Add profile visit record
  Future<bool?> addProfileVisitRecord(int visitingUserID) async {
    bool? result = await Repository().addProfileVisitRecord(
      visitingUserId: visitingUserID,
    );
    if(result != null) {
      return true;
    } else {
      return null;
    }
  }


  Future<List<UserDataModel>?> getBlockedUsers() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getBlockedUsers();
    if(users != null) {
      blockedUsers.value = users;
      update();
      isLoading(false);
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<List<UserDataModel>?> getIgnoredUsers() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getIgnoredUsers();
    if(users != null) {
      ignoredUsers.value = users;
      update();
      isLoading(false);
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<bool?> addUserToIgnoreList(int userId) async {
    UserDataModel? user = await Repository().addUserToIgnoreList(
      userId,
    );
    if(user != null) {
      ignoredUsers.add(user);
      update();
      return true;
    } else {
      return null;
    }
  }

  Future<bool?> removeUserFromIgnoreList(int userId) async {
    bool? result = await Repository().removeUserFromIgnoreList(
      userId,
    );
    if(result != null) {
      ignoredUsers.removeWhere((user) => user.id == userId);
      update();
      return true;
    } else {
      return null;
    }
  }

  Future<bool?> reportUser(int userId) async {
    bool? isConfirmed;
    await Get.defaultDialog(
      title: "Reason",
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      content: Expanded(
        child: TextFormField(
          controller: reportReasonController,
          textAlign: TextAlign.center,
          expands: true,
          maxLines: null,
          validator: (String? value) {
            return validateNotEmpty(value!, "Reason");
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: "Describe the reason of report",
            hintStyle: const TextStyle(
              color: Color(0xffC0B4CC),
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
            ),
          ),
        ),
      ),
      radius: 30,
      onConfirm: () {
        isConfirmed = true;
        Get.back();
      },
      cancelTextColor: AppColors.pinkButton,
      textCancel: "Cancel",
      textConfirm: AppTags.reportUser.tr,
      buttonColor: AppColors.pinkButton,
      confirmTextColor: AppColors.whiteColor,
    );
    if(isConfirmed != null) {
      bool? result = await Repository().reportUser(
        userId,
        reportReasonController.text,
      );
      if(result != null) {
        reportReasonController.clear();
        selectedUser.value.hasReported = true;
        try {
          int usersIndex = usersList.indexWhere((user) => user.id == userId);
          int filteredIndex = filteredUsersList.indexWhere((user) => user.id == userId);
          int newMembersIndex = newMembers.indexWhere((user) => user.id == userId);
          usersList[usersIndex].hasReported = true;
          newMembers[newMembersIndex].hasReported = true;
          filteredUsersList[filteredIndex].hasReported = true;
        } catch (e) {}
        update();
        Get.back();
        return true;
      } else {
        return null;
      }
    }
    return null;
  }

  Future<bool?> askForPhotos(int? userId) async {
    isLoading(true);
    try {
      PhotoPermission? result = await Repository().askForPhotosUser(
        userId: userId!,
      );
      if(result != null) {
        print("old ${selectedUser.value.photosPermission?.toJson()}");
        selectedUser.value.photosPermission = result;
        try {
          int usersIndex = usersList.indexWhere((user) => user.id == userId);
          int filteredIndex = filteredUsersList.indexWhere((user) => user.id == userId);
          int newMembersIndex = newMembers.indexWhere((user) => user.id == userId);
          usersList[usersIndex].photosPermission = result;
          newMembers[newMembersIndex].photosPermission = result;
          filteredUsersList[filteredIndex].photosPermission = result;
        } catch (e) {
          print("error $e");
        }
        print("new ${selectedUser.value.photosPermission?.toJson()}");

        // blockedUsers.value = users;
        update();
        isLoading(false);
        return true;
      } else {
        isLoading(false);
        return null;
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<bool?> acceptGalleryRequest(int? requestId) async {
    if(requestId != null) {
      bool? result = await Repository().acceptGalleryPermission(
        requestId,
      );
      if(result != null) {
        galleryPermittedUsers.removeWhere((element) => element.extraField == requestId);
        update();
        return true;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool?> rejectGalleryRequest(int? requestId) async {
    if(requestId != null) {
      bool? result = await Repository().rejectGalleryPermission(
        requestId,
      );
      if(result != null) {
        galleryPermittedUsers.removeWhere((element) => element.extraField == requestId);
        update();
        return true;
      } else {
        return null;
      }
    } else {
     return null;
    }
  }

  Future<bool?> deleteGalleryRequest(int? requestId) async {
    if(requestId != null) {
      bool? result = await Repository().deleteGalleryPermission(
        requestId,
      );
      if(result != null) {
        galleryPermittedUsers.removeWhere((element) => element.extraField == requestId);
        update();
        return true;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool?> unblockBlockedUser({required int userId, required int recordId}) async {
    isLoading(true);
    bool? result = await Repository().unblockBlockedUser(
      recordId: recordId
    );
    if(result != null) {
      usersList[recordId].hasBlocked = result;
      // blockedUsers.value = users;
      update();
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<bool?> blockUser({required int userId, required int recordId}) async {
    isLoading(true);
    bool? result = await Repository().blockUser(
        userId: userId
    );
    if(result != null) {
      usersList[recordId].hasBlocked = result;
      isLoading(false);
      update();
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<bool?> addUserToInterestedList({required int userID}) async {
    isLoading(true);
    var user = await Repository().addToInterestedUser(
      userId: userID,
    );
    if(user != null) {
      favouriteList.add(user);
      for (var element in favouriteList) {
        print(element.toJson());
      }

      // print("favourte list ${})}")
      update();
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<bool?> removeUserFromInterestedList({required int userID}) async {
    isLoading(true);
    bool? result = await Repository().removeUserFromInterested(
      userId: userID,
    );
    if(result != null) {
      bool userExists = favouriteList.any((user) => user.id == userID);
      if (userExists) {
        favouriteList.removeWhere((user) => user.id == userID);
      } else {
        log("user already removed");
      }
      update();
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<List<UserDataModel>?> getReceivedLikes() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getReceivedLikes();
    if(users != null) {
      receivedLikes.value = users;
      update();
      isLoading(false);
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  // Get Notification List
  Future<List<NotificationModel>?> getNotificationsList() async {
    isLoading(true);
    List<NotificationModel>? notifications = await Repository().getNotificationsList();
    if(notifications != null) {
      myNotificationsList.value = notifications;
      update();
      isLoading(false);
      return notifications;
    } else {
      isLoading(false);
      return null;
    }
  }

  void onNotificationLongPress(int index, notificationId) {
    if(!selectedNotifications.contains(index)){
      selectedNotifications.add(index);
      selectedNotificationIds.add(notificationId);
      log("on notification long press $selectedNotificationIds");
      update();
    }
  }

  onNotificationSelect(int index, conversationId, bool? value) {
    if(selectedNotifications.contains(index)){
      selectedNotifications.removeWhere((val) => val == index);
      selectedNotificationIds.removeWhere((element) => element == conversationId);
    } else {
      selectedNotifications.add(index);
      selectedNotificationIds.add(conversationId);
    }
    log("on notification select $selectedNotificationIds");
    update();
  }

  onSelectedNotificationsDelete() async {
    Dialogs.showLoadingDialog();
    try {
      if(selectedNotificationIds.isNotEmpty) {
        await Repository().deleteSelectedNotifications(
          notificationIds: selectedNotificationIds,
        ).then((value) => {
          selectedNotificationIds.clear(),
          selectedNotifications.clear()
        });

      } else {
        showShortToast("Cant delete notifications");
      }
    } finally {
      Get.back();
      update();
    }
  }


  onNotificationDelete(int? notificationID) async {
    Dialogs.showLoadingDialog();
    try {
      if(notificationID != null) {
        await Repository().deleteSingleNotification(
          notificationId: notificationID,
        );
      } else {
        showShortToast("Cant delete notification");
      }
    } finally {
      Get.back();
    }
  }

  Future<List<UserDataModel>?> getMyLikes() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getMyLikes();
    if(users != null) {
      myLikes.value = users;
      update();
      isLoading(false);
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<List<UserDataModel>?> getFavouriteList() async {
    isLoading(true);
    List<UserDataModel>? users = await Repository().getInterestedUsers();
    if(users != null) {
      favouriteList.value = users;
      update();
      isLoading(false);
      return users;
    } else {
      isLoading(false);
      return null;
    }
  }

  isAddedToFavouriteList(int? userId) {
    if(userId != null) {
      bool result = favouriteList.any((element) => element.id == userId);
      return result;
    }
    return false;
  }

  UserDataModel? getUserData(int? userId) {
    if(userId != null) {
      UserDataModel? result = usersList.firstWhere((user) => user.id == userId);
      return result;
    }
    return null;
  }

  Future purchasePackage({
    required int packageId,
    required int purchasedAmount,
    required int discount,
    required int finalAmount,
  }) async {
    isLoading(true);
    await Repository().purchasePackage(
      packageId: packageId,
      purchasedAmount: purchasedAmount,
      discount: discount,
      finalAmount: finalAmount,
    );
  }

  Future<bool?> contactMessage() async {
    isLoading(true);
    bool? result = await Repository().contactMessage(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
      email: emailController.text,
      message: messageController.text,
    );
    if(result != null) {
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  Future<List<UserDataModel>?> getReferredUser() async {
    List<UserDataModel>? users = await Repository().getReferredUser();
    return users;
  }

  bool userHasSameCountry(String? targetCountry) {
    try {
      print("target Country $targetCountry");
      print("user's country ${userData.user?.country}");
      bool result = userData.user?.country == targetCountry;
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<List<InterestModel>?> getInterestsList() async {
    List<InterestModel>? interests = await Repository().getInterestsList();
    return interests;
  }

  bool isInterestSelected(InterestModel interest) {
    bool result = selectedInterests.any((element) => element.id == interest.id);
    log("result $result");

    return result;
  }

  void onInterestTap(InterestModel interest) {
    if (selectedInterests.any((element) => element.id == interest.id)) {
      selectedInterests.removeWhere((element) => element.id == interest.id);
    } else {
      selectedInterests.add(interest);
    }
  }

  bool isInterestEmpty() {
    if(selectedInterests.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool?> saveUserInterests() async {
    isLoading(true);
    final List<int?> interestIds = selectedInterests.map((interest) => interest.id).toList();
    bool? result = await Repository().saveUserInterests(
      interestIDS: interestIds
    );
    if(result != null) {
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return null;
    }
  }

  void clearAll() {
    sideBarMenusExpanded = RxBool(false);
    selectedPhotosPageIndex = RxInt(0);
    openSelectUserReportMenuIndex = RxInt(-1);
    openSelectUserPhotoMenuIndex = RxInt(-1);
    update();
  }


}