import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/user_model.dart';
import 'package:nybal/widgets/dialogs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../helpers/local_data_helper.dart';
import '../models/config_model.dart';
import '../models/country_model.dart';
import '../models/photo_model.dart';
import '../models/religion_model.dart';
import '../repository/repository.dart';
import '../utils/app_tags.dart';
import '../utils/functions.dart';
import '../utils/validators.dart';
import '../views/dashboards/dashboard.dart';
import 'navigation_controller.dart';

class WifeRegistrationController extends GetxController {
  ImagePicker _imagePicker = ImagePicker();
  final SettingController settingController = Get.find<SettingController>();
  final UserController userController = Get.find<UserController>();
  final NavigationController navController = Get.find<NavigationController>();
  RxInt currentStep = 1.obs;
  RxInt stepLength = 5.obs;
  RxBool complete = false.obs;
  RxBool startFromScratch = false.obs;
  RxBool termsAndConditions = false.obs;
  var iHaveTakenOath = false.obs;
  final int minHeight = 100;
  DateTime? _selectedDate;
  List<String> heightOptions = [AppTags.chooseYourHeightHint.tr];

  void heightOptionBuilder() {
    heightOptions = List.generate(273 - minHeight + 1, (index) => "${minHeight + index} (cm)");
  }

  RxList<ReligionModel> religions = RxList();
  RxList<CountryModel> countries = RxList();
  RxList<StateModel> statesByCountry = RxList();
  RxList<CityModel> citiesByState = RxList();


  // Step one
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  // Step two
  CountryModel selectedCountry = CountryModel(
    name: AppTags.selectACountryHint.tr,
  );
  StateModel selectedState = StateModel(
    name: AppTags.selectAStateHint.tr,
  );
  CityModel selectedCity = CityModel(
    name: AppTags.selectACityHint.tr,
  );

  @override
  void onInit() {
    getCountriesList();
    getReligionsList();
    heightOptionBuilder();
    _promptPermissionSetting();
    super.onInit();
  }

  RxString selectedHeight = RxString(AppTags.choosePartnerHeightHint.tr);
  RxString selectedWeight = RxString(AppTags.choosePartnerWeightHint.tr);
  RxString selectedDoesShePray = RxString(AppTags.doesShePray.tr);
  RxString selectedIsSheReligious = RxString(AppTags.isSheReligious.tr);
  ReligionModel selectedReligion = ReligionModel(
    name: AppTags.selectReligion.tr,
  );
  RxString selectedChildren = RxString(AppTags.children.tr);
  RxString selectedPhysicalCondition = RxString(AppTags.choosePhysicalConditionHint.tr);
  RxString selectedSkinColor = RxString(AppTags.skinColor.tr);
  Educations selectedEducation = Educations(
    title: AppTags.chooseEducationHint.tr,
  );
  RxString selectedHaveJob = RxString(AppTags.doYouHaveAJob.tr);
  RxString selectedDoesSheWearHijab = RxString(AppTags.doesSheWearHijab.tr);
  RxString selectedEthnicity = RxString(AppTags.selectEthnicity.tr);

  //Step Five
  TextfieldTagsController tagController = TextfieldTagsController();
  TextEditingController dobController = TextEditingController();
  TextEditingController partnerSpecsController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

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

  // Drop Down Country Change
  onCountryChange(CountryModel country) {
    selectedCountry = country;
    getStatesListByCountry(country.id.toString());
    selectedState.name = AppTags.selectAStateHint.tr;
    update();
  }
  // Drop Down State Change
  onStateChange(StateModel state){
    selectedState = state;
    getCitiesListByState(state.id.toString());
    selectedCity = CityModel(name: AppTags.selectACityHint.tr);
    update();
  }
  // Drop Down City Change
  onCityChange(CityModel city){
    selectedCity = city;
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
  // Drop Down Does She Pray Change
  onDoesShePrayChange(String option) {
    selectedDoesShePray.value = option;
    update();
  }
  // Drop Down Religious Change
  onIsSheReligiousChange(String option) {
    selectedIsSheReligious.value = option;
    getReligionsList();
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
  }
  // Drop Down Have a job Change
  onHaveJobChange(String option) {
    selectedHaveJob.value = option;
    update();
  }
  // Drop Down Does She Wear Hijab Change
  onDoesSheWearHijabChange(String option) {
    selectedDoesSheWearHijab.value = option;
    update();
  }
  // Drop Down Ethnicity Change
  onEthnicityChange(String option) {
    selectedEthnicity.value = option;
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

  bool isDoesShePraySelected() {
    if(selectedDoesShePray.value != AppTags.doesShePray.tr) {
      return true;
    } else {
      return false;
    }
  }
  bool isSheReligiousSelected() {
    if(selectedIsSheReligious.value != AppTags.isSheReligious.tr) {
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
  bool isDoYouWearHijabSelected() {
    if(selectedDoesSheWearHijab.value != AppTags.doesSheWearHijab.tr) {
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
  bool isReligionSelected() {
    if(selectedReligion.name != AppTags.selectReligion.tr) {
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
    final requiredFields = [
      if (step == 2) firstNameController.text,
      if (step == 2) lastNameController.text,
      if (step == 2) userNameController.text,
      if (step == 2) emailController.text,
      if (step == 2) passwordController.text,
      if (step == 3) selectedCountry.name,
      if (step == 3) selectedState.name,
      if (step == 3) selectedCity.name,
      if (step == 3) selectedHeight.value,
      if (step == 3) selectedWeight.value,
      if (step == 3) selectedSkinColor.value,
      if (step == 4) selectedPhysicalCondition.value,
      if (step == 4) selectedEducation.title,
      if(step == 4) selectedEthnicity.value,
      if(step == 4) selectedIsSheReligious.value,
      if(step == 4) selectedReligion.name,
      if(step == 4) selectedDoesSheWearHijab.value,
      if(step == 4) selectedDoesShePray.value,
      if(step == 5)
        partnerSpecsController.text.isEmpty ? AppTags.specificationsOfYourPartnerThatYouWantToRelateTo.tr: null,
      if(step == 5) _selectedDate ?? "Enter her date of birth",

    ];

    for (final field in requiredFields) {
      // if (field is List<String> && field.isEmpty) {
      //   showShortToast("Lang speaks are required");
      //   return;
      // }
      if (field is String && field.isEmpty) {
        showShortToast("Fields are required");
        return;
      } else if (field is String && field == AppTags.selectACountryHint.tr) {
        showShortToast("Country is required");
        return;
      } else if (field is String && field == AppTags.selectAStateHint.tr) {
        showShortToast("State is required");
        return;
      } else if (field is String && field == AppTags.selectACityHint.tr) {
        showShortToast("City is required");
        return;
      } else if (field is String && field == AppTags.choosePhysicalConditionHint.tr) {
        showShortToast("Physical condition is required");
        return;
      } else if (field is String && field == AppTags.choosePartnerHeightHint.tr) {
        showShortToast("Height is required");
        return;
      } else if (field is String && field == AppTags.choosePartnerWeightHint.tr) {
        showShortToast("Weight is required");
        return;
      } else if (field is String && field == AppTags.skinColor.tr) {
        showShortToast("Skin Color is required");
        return;
      } else if (field is String && field == AppTags.chooseEducationHint.tr) {
        showShortToast("Education is required");
        return;
      } else if (field is String && field == AppTags.selectEthnicity.tr) {
        showShortToast("Ethnicity is required");
        return;
      } else if (field is String && field == AppTags.specificationsOfYourPartnerThatYouWantToRelateTo.tr) {
        showShortToast("Partner specifications are required");
        return;
      }
      else if (field is String && field == AppTags.isSheReligious.tr) {
        showShortToast("Please specify is she religious");
        return;
      }
      else if (field is String && field == AppTags.selectReligion.tr && selectedIsSheReligious.value == AppTags.yes.tr) {
        showShortToast("Religion is required");
        return;
      }
      else if (field is String && field == AppTags.doesSheWearHijab.tr) {
        showShortToast("Please specify does she wear hijab");
        return;
      }
      else if (field is String && field == AppTags.doesShePray.tr) {
        showShortToast("Please specify does she pray");
        return;
      }
      else if (field is String && field == "Enter her date of birth") {
        showShortToast("Please select date of birth");
        return;
      }
    }

    currentStep.value = step;
    if (currentStep.value > stepLength.value) {
      complete.value = true;
    }
    update();
  }

  onStartFromScratchChange(value){
    startFromScratch.value = value!;
    update();
  }

  onTermsAndConditionChange(value){
    termsAndConditions.value = value!;
    update();
  }

  isIHaveTakenOathUpdate(value){
    iHaveTakenOath.value = value!;
    update();
  }

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

  Future<bool?> wifeRegistration() async {
    Dialogs.showLoadingDialog();
    String? base64string;
    if(imageFile != null) {
      base64string = kIsWeb ? await convertImageToBase64(imageFile!.path): await imageToBase64(filePath: imageFile!.path);
    }

    // print("country: ${selectedCountry.name}");
    // print("state: ${selectedState.name}");
    // print("city: ${selectedCity.name}");
    // // appearance: {
    // // "height": isHeightSelected() ? selectedHeight.value: "",
    // // "weight": isWeightSelected() ? selectedWeight.value: "",
    // // "skin_color": isSkinColorSelected() ? selectedSkinColor.value: "",
    // // "hijab": selectedDoesSheWearHijab.value == AppTags.yes.tr ? 1: 0,
    // // "body_type": isPhysicalConditionSelected() ? selectedPhysicalCondition.value: ""
    // // },
    // print("religion: ${selectedReligion.name}");
    // print("doesShePray: ${selectedDoesShePray.value}");
    // print("education: ${selectedEducation.title}");
    // print("ethnicity: ${selectedEthnicity.value}");
    // print("dob: ${dobController.text}");
    // print("specifications: ${partnerSpecsController.text}");
    // print("profilePic: $base64string");
    //
    // return true;
    UserDataModel? updatedUser = await Repository().wifeRegistration(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      userName: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
      country: isCountrySelected() ? selectedCountry.name!: "",
      state: isStateAndCountrySelected() ? selectedState.name!: "",
      city: isCitySelected() ? selectedCity.name!: "",
      latitude: "123",
      longitude: "123",
      appearance: {
        "height": isHeightSelected() ? selectedHeight.value: "",
        "weight": isWeightSelected() ? selectedWeight.value: "",
        "skin_color": isSkinColorSelected() ? selectedSkinColor.value: "",
        "hijab": selectedDoesSheWearHijab.value == AppTags.yes.tr ? 1: 0,
        "body_type": isPhysicalConditionSelected() ? selectedPhysicalCondition.value: ""
      },
      religion: isReligionSelected() ? selectedReligion.name!: "",
      doesShePray: isDoesShePraySelected() ? selectedDoesShePray.value: "",
      // children: selectedMaritalStatus.value != AppTags.single.tr ? selectedChildren.value: "",
      education: isEducationSelected() ? selectedEducation.title!: "",
      ethnicity: isEthnicitySelected() ? selectedEthnicity.value: "",
      dob: dobController.text,
      specifications: partnerSpecsController.text,
      profilePic: base64string
    );
    if(updatedUser != null) {
      userController.userData.user = updatedUser;
      navController.selectedNavIndex = 1;
      navController.selectedIndex(0);
      Get.offAll(()=> const DashBoardScreen());
      return true;
    } else {
      return null;
    }
  }

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
