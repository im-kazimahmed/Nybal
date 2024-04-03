import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nybal/Widgets/dialogs.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/config_model.dart';
import 'package:nybal/models/photo_model.dart';
import 'package:nybal/utils/validators.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../helpers/local_data_helper.dart';
import '../models/country_model.dart';
import '../models/religion_model.dart';
import '../repository/repository.dart';
import '../routes/routes.dart';
import '../utils/app_tags.dart';
import '../utils/functions.dart';

class UpdateProfileController extends GetxController {
  final SettingController settingController = Get.find<SettingController>();
  final UserController userController = Get.find<UserController>();
  RxInt currentStep = 1.obs;
  RxInt stepLength = 6.obs;
  RxBool complete = false.obs;
  RxBool startFromScratch = false.obs;
  RxBool termsAndConditions = false.obs;
  RxBool isLoading = RxBool(true);
  var iHaveTakenOath = false.obs;
  final int minHeight = 100;
  DateTime? _selectedDate;
  List<String> heightOptions = [AppTags.chooseYourHeightHint.tr];
  ImagePicker _imagePicker = ImagePicker();

  void heightOptionBuilder() {
    heightOptions = List.generate(200 - minHeight + 1, (index) => "${minHeight + index} (cm)");
  }

  @override
  void onInit() {
    getReligionsList();
    heightOptionBuilder();
    _promptPermissionSetting();
    super.onInit();
  }

  RxList<ReligionModel> religions = RxList();
  RxList<ReligionModel> subReligions = RxList();
  RxList<CountryModel> countries = RxList();
  RxList<StateModel> statesByCountry = RxList();
  RxList<CityModel> citiesByState = RxList();

  CountryModel selectedCountry = CountryModel(
    name: AppTags.selectACountryHint.tr,
  );
  CountryModel selectedNationality = CountryModel(
    name: AppTags.chooseYourNationalityHint.tr,
  );
  StateModel selectedState = StateModel(
    name: AppTags.selectAStateHint.tr,
  );
  CityModel selectedCity = CityModel(
    name: AppTags.selectACityHint.tr,
  );

  RxString selectedHeight = RxString(AppTags.chooseYourHeightHint.tr);
  RxString selectedWeight = RxString(AppTags.chooseYourWeightHint.tr);
  RxString selectedDoYouPray = RxString(AppTags.doYouPray.tr);
  RxString selectedAreYouReligious = RxString(AppTags.areYouReligious.tr);
  ReligionModel selectedReligion = ReligionModel(
    name: AppTags.selectReligion.tr,
  );
  ReligionModel selectedSubReligion = ReligionModel(
    name: AppTags.selectSubReligion.tr,
  );
  RxString selectedDoYouSmoke = RxString(AppTags.doYouSmoke.tr);
  RxString selectedWillingToRelocate = RxString(AppTags.willingToRelocate.tr);
  RxString selectedMaritalStatus = RxString(AppTags.maritalStatus.tr);
  RxString selectedChildren = RxString(AppTags.children.tr);
  RxString selectedPhysicalCondition = RxString(AppTags.choosePhysicalConditionHint.tr);
  RxString selectedSkinColor = RxString(AppTags.skinColor.tr);
  Educations selectedEducation = Educations(
    title: AppTags.chooseEducationHint.tr,
  );
  RxString selectedHaveJob = RxString(AppTags.doYouHaveAJob.tr);
  RxString selectedHaveBeard = RxString(AppTags.doYouHaveABeard.tr);
  RxString selectedDoYouWearHijab = RxString(AppTags.doYouWearHijab.tr);
  RxString selectedEthnicity = RxString(AppTags.selectEthnicity.tr);
  RxString selectedFinancialStatus = RxString(AppTags.financialStatus.tr);

  Future getCountriesList() async {
    var data = await Repository().getCountriesList();
    if(data != null) {
      countries.value = data;
    } else {
      var countries = LocalDataHelper().getAllCountries();
      if(countries != null) {
        countries = countries;
      } else {
        selectedCountry = CountryModel(name: AppTags.selectACountryHint.tr);
        selectedCity = CityModel(name: AppTags.selectACityHint.tr);
        selectedState = StateModel(name: AppTags.selectAStateHint.tr);
      }
    }
  }

  Future getReligionsList() async {
    var data = await Repository().getReligionsList();
    if(data != null) {
      religions.value = data;
      LocalDataHelper().saveAllReligions(data);
    } else {
      var religions = LocalDataHelper().getAllReligions();
      if(religions != null) {
        religions = religions;
      }
    }
  }

  Future getStatesListByCountry(String countryId) async {
    var states = LocalDataHelper().getStatesByCountry(countryId);
    if(states != null) {
      statesByCountry.value = states;
    } else {
      var data = await Repository().getStatesListByCountry(countryId);
      if(data != null) {
        statesByCountry.value = data;
        LocalDataHelper().saveAllStatesByCountry(countryId, data);
      } else {
        selectedState = StateModel(name: AppTags.selectAStateHint.tr);
      }
    }
  }

  Future getCitiesListByState(String stateId) async {
    var cities = LocalDataHelper().getCitiesByState(stateId);
    if(cities != null) {
      citiesByState.value = cities;
    }else {
      var data = await Repository().getCitiesListByState(stateId);
      if(data != null) {
        citiesByState.value = data;
      } else {
        citiesByState = RxList();
        selectedCity = CityModel(name: AppTags.selectACityHint.tr);
      }
    }
  }

  Future getSubReligionsByReligionId(String religionId) async {
    var religions = LocalDataHelper().getSubReligionsByReligion(religionId);
    if(religions != null) {
      subReligions.value = religions;
    } else {
      var data = await Repository().getSubReligionByReligionId(religionId);
      if(data != null) {
        subReligions.value = data;
        LocalDataHelper().saveAllSubReligionsByReligion(religionId, data);
      } else {
        selectedReligion = ReligionModel(name: AppTags.selectSubReligion.tr);
      }
    }
  }

  Future updateUserAdditionalInfo() async {
    Dialogs.showLoadingDialog();
    String? base64string;
    if(imageFile != null) {
      base64string = kIsWeb ? await convertImageToBase64(imageFile!.path): await imageToBase64(filePath: imageFile!.path);
    }
    await Repository().updateUserInformation(
      country: isCountrySelected() ? selectedCountry.name: "",
      selectedCountryId: isCountrySelected() ? selectedCountry.id: null,
      state: isStateAndCountrySelected() ? selectedState.name: "",
      city: isCitySelected() ? selectedCity.name: "",
      latitude: "123",
      longitude: "123",
      appearance: {
        "height": isHeightSelected() ? selectedHeight.value: "",
        "weight": isWeightSelected() ? selectedWeight.value: "",
        "skin_color": isSkinColorSelected() ? selectedSkinColor.value: "",
        "hijab": userController.userData.user?.gender == "Male" ? null: selectedDoYouWearHijab.value == AppTags.yes.tr ? 1: 0,
        "smoking": selectedDoYouSmoke.value == AppTags.yes.tr ? 1: 0,
        "beard": selectedHaveBeard.value == AppTags.yes.tr ? 1: 0,
        "body_type": isPhysicalConditionSelected() ? selectedPhysicalCondition.value: ""
      },
      religion: isReligionSelected() ? selectedReligion.name: "",
      subReligion: isSubReligionSelected() ? selectedSubReligion.name: "",
      prayer: isDoYouPraySelected() ? selectedDoYouPray.value: "",
      willingToRelocate: isWillingToRelocateSelected() ? selectedWillingToRelocate.value: "",
      maritalStatus: isMaritalStatusSelected() ? selectedMaritalStatus.value: "",
      children: selectedMaritalStatus.value != AppTags.single.tr ? selectedChildren.value: "",
      education: isEducationSelected() ? selectedEducation.title: "",
      monthlyIncome: salaryController.text.isEmpty ? "0": salaryController.text,
      langSpeak: tagController.getTags,
      ethnicity: isEthnicitySelected() ? selectedEthnicity.value: "",
      financialStatus: isFinancialStatusSelected() ? selectedFinancialStatus.value:  "",
      dob: dobController.text,
      aboutMe: aboutMeController.text,
      partnerSpecification: partnerSpecsController.text,
      mySpecification: mySpecsController.text,
      phone: phoneController.text,
      profilePic: base64string
    ).then((value) {
      Get.back();
      if(value == true) {
        Get.offAllNamed(Routes.dashboardScreen);
      }
    });
  }

  // Drop Down Country Change
  onCountryChange(CountryModel country) {
    print("country ${country.toJson()}");
    selectedCountry = country;
    selectedState.name = AppTags.selectAStateHint.tr;

    update();
    getStatesListByCountry(country.id.toString());
  }
  // Drop Down State Change
  onStateChange(StateModel state){
    selectedState = state;
    selectedCity.name = AppTags.selectACityHint.tr;
    update();
    getCitiesListByState(state.id.toString());
  }
  // Drop Down City Change
  onCityChange(CityModel city){
    selectedCity = city;
    update();
  }
  // Drop Down Nationality Change
  onNationalityChange(CountryModel country) {
    selectedNationality = country;
    update();
  }
  // Drop Down Height Change
  onHeightChange(String height) {
    selectedHeight.value = height;
    update();
  }
  // Drop Down Weight Change
  onWeightChange(String weight) {
    selectedWeight.value = weight;
    update();
  }
  // Drop Down Do You Pray Change
  onDoYouPrayChange(String option) {
    selectedDoYouPray.value = option;
    update();
  }
  // Drop Down Religious Change
  onAreYouReligiousChange(String option) {
    selectedAreYouReligious.value = option;
    getReligionsList();
    update();
  }
  // Drop Down Do You Smoke Change
  onDoYouSmokeChange(String option) {
    selectedDoYouSmoke.value = option;
    update();
  }
  // Drop Down Willing To Relocate Change
  onWillingToRelocateChange(String option) {
    selectedWillingToRelocate.value = option;
    update();
  }
  // Drop Down Marital Status Change
  onMaritalStatusChange(String option) {
    selectedMaritalStatus.value = option;
    if(option == AppTags.single.tr){
      selectedChildren.value = AppTags.children.tr;
    }
    update();
  }
  // Drop Down Children Change
  onChildrenChange(String option) {
    selectedChildren.value = option;
    update();
  }
  // Drop Down Choose Physical Condition Change
  onPhysicalConditionChange(String option) {
    selectedPhysicalCondition.value = option;
    update();
  }
  // Drop Down Skin Color Change
  onSkinColorChange(String option) {
    selectedSkinColor.value = option;
    update();
  }
  // Drop Down Education Change
  onEducationChange(Educations option) {
    selectedEducation = option;
    update();
  }
  // Drop Down Religion Change
  onReligionChange(ReligionModel religion) {
    selectedReligion = religion;
    update();
    getSubReligionsByReligionId(religion.id.toString());
  }
  // Drop Down Sub Religion Change
  onSubReligionChange(ReligionModel religion) {
    selectedSubReligion = religion;
    update();
  }
  // Drop Down Have a job Change
  onHaveJobChange(String option) {
    selectedHaveJob.value = option;
    update();
  }
  // Drop Down Do You Have Beard Change
  onHaveBeardChange(String option) {
    selectedHaveBeard.value = option;
    update();
  }
  // Drop Down Do You Wear Hijab Change
  onDoYouWearHijabChange(String option) {
    selectedDoYouWearHijab.value = option;
    update();
  }
  // Drop Down Ethnicity Change
  onEthnicityChange(String option) {
    selectedEthnicity.value = option;
    update();
  }
  // Drop Down Financial Status Change
  onFinancialStatusChange(String option) {
    selectedFinancialStatus.value = option;
    update();
  }

  bool isStateAndCountrySelected() {
    if(selectedCountry.name != AppTags.selectACountryHint.tr && selectedState.name != AppTags.selectAStateHint.tr) {
      return true;
    } else {
      return false;
    }
  }

  bool isCountrySelected() {
    if(selectedCountry.name != AppTags.selectACountryHint.tr) {
      return true;
    } else {
      return false;
    }
  }

  bool isCitySelected() {
    if(selectedCity.name != AppTags.selectACityHint.tr) {
      return true;
    } else {
      return false;
    }
  }

  bool isNationalitySelected() {
    if(selectedNationality.name != AppTags.chooseYourNationalityHint.tr) {
      return true;
    } else {
      return false;
    }
  }

  bool isHeightSelected() {
    if(selectedHeight.value != AppTags.chooseYourHeightHint.tr) {
      return true;
    } else {
      return false;
    }
  }

  bool isWeightSelected() {
    if(selectedWeight.value != AppTags.chooseYourWeightHint.tr) {
      return true;
    } else {
      return false;
    }
  }

  bool isDoYouPraySelected() {
    if(selectedDoYouPray.value != AppTags.doYouPray.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isAreYouReligiousSelected() {
    if(selectedAreYouReligious.value != AppTags.areYouReligious.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isDoYouSmokeSelected() {
    if(selectedDoYouSmoke.value != AppTags.doYouSmoke.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isWillingToRelocateSelected() {
    if(selectedWillingToRelocate.value != AppTags.willingToRelocate.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isMaritalStatusSelected() {
    if(selectedMaritalStatus.value != AppTags.maritalStatus.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isChildrenSelected() {
    if(selectedChildren.value != AppTags.children.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isPhysicalConditionSelected() {
    if(selectedPhysicalCondition.value != AppTags.choosePhysicalConditionHint.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isSkinColorSelected() {
    if(selectedSkinColor.value != AppTags.skinColor.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isEducationSelected() {
    if(selectedEducation.title != AppTags.chooseEducationHint.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isHaveJobSelected() {
    if(selectedHaveJob.value != AppTags.doYouHaveAJob.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isHaveBeardSelected() {
    if(selectedHaveBeard.value != AppTags.doYouHaveABeard.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isDoYouWearHijabSelected() {
    if(selectedDoYouWearHijab.value != AppTags.doYouWearHijab.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isEthnicitySelected() {
    if(selectedEthnicity.value != AppTags.selectEthnicity.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isFinancialStatusSelected() {
    if(selectedFinancialStatus.value != AppTags.financialStatus.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isReligionSelected() {
    if(selectedReligion.name != AppTags.selectReligion.tr) {
      return true;
    } else {
      return false;
    }
  }

  bool isSubReligionSelected() {
    if(selectedSubReligion.name != AppTags.selectSubReligion.tr) {
      return true;
    } else {
      return false;
    }
  }

  next() {
    if (currentStep.value <= stepLength.value) {
      goTo(currentStep.value + 1);
    }
  }

  back() {
    if (currentStep.value > 1) {
      goTo(currentStep.value - 1);
    }
  }

  goTo(int step) {
    final additionalFields = settingController.appConfig?.additionalFieldsRequired;
    // additionalFields?.isPartnerSpecsEnabled = true;
    if (additionalFields != null) {
      final requiredFields = [
        if (step == 2) selectedCountry.name,
        if (step == 2 && additionalFields.isCityEnabled == true) selectedCity.name,
        if (step == 2 && additionalFields.isStateEnabled == true) selectedState.name,
        if (step == 3 && additionalFields.isAppearanceEnabled == true)
          selectedPhysicalCondition.value,
        if (step == 3 && additionalFields.isAppearanceEnabled == true) selectedHeight.value,
        if (step == 3 && additionalFields.isAppearanceEnabled == true) selectedWeight.value,
        if (step == 3 && additionalFields.isAppearanceEnabled == true)
          selectedSkinColor.value,
        if (step == 4 && additionalFields.isWillingToRelocateEnabled == true)
          selectedWillingToRelocate.value,
        if (step == 4 && additionalFields.isMaritalStatusEnabled == true)
          selectedMaritalStatus.value,
        if (step == 4 && additionalFields.isEducationEnabled == true)
          selectedEducation.title,
        if (step == 5 && additionalFields.isLangSpeaksEnabled == true)
          tagController.getTags,
        if(step == 5 && additionalFields.isEthnicityEnabled == true)
          selectedEthnicity.value,
        if(step == 5 && additionalFields.isFinancialStatusEnabled == true)
          selectedFinancialStatus.value,
        if(step == 5 && additionalFields.isAboutMeEnabled == true)
          aboutMeController.text.isEmpty ? AppTags.describeYourself.tr: null,
        if(step == 5 && additionalFields.isPartnerSpecsEnabled == true)
          partnerSpecsController.text.isEmpty ? AppTags.specificationsOfYourPartnerThatYouWantToRelateTo.tr: null,
      ];

      for (final field in requiredFields) {
        print("check field ${field} required ${requiredFields.toString()}");
        if (field is List<String> && field.isEmpty) {
          showShortToast("Lang speaks are required");
          return;
        } else if (field is String && field == AppTags.selectACountryHint.tr) {
          showShortToast("Country is required");
          return;
        } else if (field is String && field == AppTags.selectACityHint.tr) {
          showShortToast("City is required");
          return;
        } else if (field is String && field == AppTags.selectAStateHint.tr) {
          showShortToast("State is required");
          return;
        } else if (field is String && field == AppTags.choosePhysicalConditionHint.tr) {
          showShortToast("Physical condition is required");
          return;
        } else if (field is String && field == AppTags.chooseYourHeightHint.tr) {
          showShortToast("Height is required");
          return;
        } else if (field is String && field == AppTags.chooseYourWeightHint.tr) {
          showShortToast("Weight is required");
          return;
        } else if (field is String && field == AppTags.skinColor.tr) {
          showShortToast("Skin Color is required");
          return;
        } else if (field is String && field == AppTags.willingToRelocate.tr) {
          showShortToast("Willing to relocate is required");
          return;
        } else if (field is String && field == AppTags.maritalStatus.tr) {
          showShortToast("Marital Status is required");
          return;
        } else if (field is String && field == AppTags.chooseEducationHint.tr) {
          showShortToast("Education is required");
          return;
        } else if (field is String && field == AppTags.selectEthnicity.tr) {
          showShortToast("Ethnicity is required");
          return;
        } else if (field is String && field == AppTags.financialStatus.tr) {
          showShortToast("Financial status is required");
          return;
        } else if (field is String && field == AppTags.describeYourself.tr) {
          showShortToast("Please describe yourself little bit");
          return;
        } else if (field is String && field == AppTags.specificationsOfYourPartnerThatYouWantToRelateTo.tr) {
          showShortToast("Partner specifications are required");
          return;
        }
      }
    }

    currentStep.value = step;
    if (currentStep.value > stepLength.value) {
      complete.value = true;
    }
    update();
  }


  onTermsAndConditionChange(value) {
    termsAndConditions.value = value!;
    update();
  }

  isIHaveTakenOathUpdate(value) {
    iHaveTakenOath.value = value!;
    update();
  }

  var langList = <String>[
    "English",
    "Arabic",
    "Spanish",
    "Chinese",
    "Hindi",
    "French",
    "Russian",
    "Portuguese",
    "Bengali",
    "Japanese",
    "German",
    "Korean",
    "Turkish",
    "Italian",
    "Dutch",
    "Swedish",
    "Norwegian",
    "Greek",
    "Thai",
    "Hebrew",
    "Vietnamese",
    "Polish",
    "Tagalog",
    "Swahili",
    "Ukrainian",
    "Romanian",
    "Finnish",
    "Czech",
    "Hungarian",
    "Malay",
    "Indonesian",
    "Danish",
    "Slovak",
    "Bulgarian",
    "Croatian",
    "Serbian",
    "Kurdish",
    "Urdu",
    "Sindhi",
    "Persian",
    "Tamil",
    "Sinhala",
    "Gujarati",
    "Punjabi",
    "Kannada",
    "Telugu",
    "Marathi",
    "Nepali",
    "Burmese",
    "Mongolian",
    "Samoan",
    "Fijian",
    "Maori",
  ];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      dobController.text = "${picked.day}:${picked.month}:${picked.year}";
      update();
    }
  }

  //Step Five
  TextfieldTagsController tagController = TextfieldTagsController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController partnerSpecsController = TextEditingController();
  TextEditingController mySpecsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  Future<bool> _promptPermissionSetting() async {
    if(kIsWeb || Platform.isWindows) {
      return true;
    }
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted &&
              await Permission.videos.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  CroppedFile? imageFile;

  Future<bool> selectImage(BuildContext context, ImageSource source) async {
    // XFile? pickedFile = await ImagePicker().pickImage(source: source);
    // if(pickedFile != null) {
    //   return cropImage(context, pickedFile);
    // }
    try {
      XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        return cropImage(context, pickedFile);
      }
      return false;
    } catch (e) {
      print('Error picking image: $e');
      return false;
    }
  }

  Future<bool> cropImage(BuildContext context, XFile file) async{
    ImageCropper imgCropper = ImageCropper();
    CroppedFile? croppedImage = await imgCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
      uiSettings: [
        WebUiSettings(
          context: context,
          boundary: CroppieBoundary(
            height: 50.h.toInt(),
            width: 50.w.toInt(),
          ),
          viewPort: CroppieViewPort(
            height: 40.h.toInt(),
            width: 40.w.toInt(),
          )
        ),
      ]
    );

    if(croppedImage != null){
      imageFile = croppedImage;
      update();
      return true;
    }
    return false;
  }

  Future<PhotoModel?> uploadGalleryImage() async {
    if(imageFile != null) {
      String base64 = "";
      if(kIsWeb) {
        base64 = await convertImageToBase64(imageFile!.path);
      } else{
        base64 = await imageToBase64(filePath: imageFile!.path);
      }
      PhotoModel? photo = await Repository().uploadUserGalleryPhoto(
        userController.userData.user!.id!,
        base64,
      );
      return photo;
    }
    return null;
  }

  selectAndUploadImage(BuildContext context) async {
    bool isSelected = await selectImage(context, ImageSource.gallery);
    if(isSelected) {
      uploadGalleryImage();
    }
  }

}
