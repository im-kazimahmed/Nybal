import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/controllers/splash_controller.dart';
import 'package:nybal/models/config_model.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../helpers/data.dart';
import '../../Widgets/theme_data.dart';
import '../../utils/validators.dart';
import '../../widgets/top_bar.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final authController = Get.find<AuthController>();
  final navController = Get.find<NavigationController>();
  final langController = Get.find<LanguageController>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<ConfigModel>(
          future: SplashController().handleConfigData(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoader();
            } else if(snapshot.hasData) {
              AppConfig config = snapshot.data!.appConfig!;
              return Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 20.w),
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          Text(
                            AppTags.signUp.tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "myFontLight",
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF574667),
                            ),
                          ),
                          const SizedBox(height: 30),
                          if(config.signupFieldsRequired?.isFirstNameEnabled == true)
                            ...[
                              Text(
                                AppTags.firstName.tr,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF574667),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: authController.firstNameController,
                                textAlign: TextAlign.center,
                                validator: (String? value) {
                                  return validateNotEmpty(value!, AppTags.firstName.tr);
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: AppTags.firstNameHint.tr,
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
                              const SizedBox(height: 20),
                            ],
                          if(config.signupFieldsRequired?.isLastNameEnabled == true)
                            ...[
                              Text(
                                AppTags.lastName.tr,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF574667),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: authController.lastNameController,
                                textAlign: TextAlign.center,
                                validator: (String? value) {
                                  return validateNotEmpty(value!, AppTags.lastName.tr);
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: AppTags.lastNameHint.tr,
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
                              const SizedBox(height: 20),
                            ],
                          if(config.signupFieldsRequired?.isUsernameEnabled == true)
                            ...[
                              Text(
                                AppTags.userName.tr,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF574667),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: authController.userNameControllerSignup,
                                textAlign: TextAlign.center,
                                validator: (String? value) {
                                  return validateNotEmpty(value!, AppTags.userName.tr);
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: AppTags.userNameHint.tr,
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
                              const SizedBox(height: 20),
                            ],
                          Text(
                            AppTags.email.tr,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF574667),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: authController.emailControllerSignup,
                            textAlign: TextAlign.center,
                            validator: (String? value) {
                              return validateNotEmpty(value!, AppTags.email.tr);
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: AppTags.yourEmailHint.tr,
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
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              AppTags.password.tr,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF574667),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(()=> TextFormField(
                            controller: authController.passwordControllerSignup,
                            obscureText: authController.isPasswordVisible.value,
                            textAlign: TextAlign.center,
                            validator: (String? value) {
                              return validateNotEmpty(value!, AppTags.password.tr);
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: AppTags.password.tr,
                              hintStyle: const TextStyle(
                                color: Color(0xffC0B4CC),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () => authController.isPasswordVisibleUpdate(),
                                child: authController.isPasswordVisible.isFalse ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: AppColors.pinkButton,
                                ): const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              labelStyle: const TextStyle(fontSize: 12),
                              contentPadding: const EdgeInsets.only(left: 30),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                              ),
                            ),
                          )),
                          const SizedBox(height: 20),
                          if(config.signupFieldsRequired?.isGenderEnabled == true)
                            ...[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  AppTags.gender.tr,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF574667),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Obx(()=>
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey[50],
                                          ),
                                          alignment: Alignment.center,
                                          child: DropdownButton<String>(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            underline: const Text(""),
                                            style: const TextStyle(textBaseline: null, color: Colors.black),
                                            menuMaxHeight: Get.height / 2,
                                            hint: Text(AppTags.selectGender.tr),
                                            alignment: Alignment.center,
                                            isExpanded: true,
                                            value: authController.selectedGender.value,
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            iconSize: 20,
                                            items: genders.map<DropdownMenuItem<String>>((gender) {
                                              return DropdownMenuItem<String>(
                                                alignment: Alignment.center,
                                                value: gender["value"],
                                                child: Text(gender["value"]),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              authController.selectedGender.value = newValue!;
                                            },
                                          ),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          const SizedBox(height: 20),
                          const Text(
                            "Referral Code",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF574667),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: authController.referredByControllerSignup,
                            textAlign: TextAlign.center,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: "Enter referral code",
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    AppTags.acceptTermsOfPrivacyAndPolicy.tr,
                                    style: const TextStyle(
                                      color: Color(0xffC0B4CC),
                                    ),
                                  ),
                                  Obx(()=> Checkbox(
                                    activeColor: Colors.deepPurple,
                                    side: const BorderSide(color: AppColors.pinkButton),
                                    value: authController.termsAndConditions.value,
                                    onChanged: (value) {
                                      authController.isTermsAndConditionsUpdate();
                                    },
                                  )),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () => signUp(),
                            child: Container(
                              height: 6.h,
                              width: !ResponsiveWidget.isSmallScreen(context) ? 20.w: 70.w,
                              decoration: const BoxDecoration(
                                color: Color(0xff27B2CC),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: !ResponsiveWidget.isSmallScreen(context) ? 0: 10.w, vertical: 0.0),
                              child: Text(
                                AppTags.signUp.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          if(config.socialMediaLogin?.isGoogleEnabled == true)
                            ...[
                              Expanded(
                                child: InkWell(
                                  onTap: () => authController.continueWithGoogle(),
                                  child: Container(
                                    height: 6.h,
                                    width:  20.w,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffE13F35),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppTags.continueWithGoogle.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 3.5.sp,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Image.asset("assets/images/google_g.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          if(config.socialMediaLogin?.isFacebookEnabled == true)
                            ...[
                              Expanded(
                                child: Container(
                                  height: 6.h,
                                  width:  20.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff0777E8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppTags.continueWithFacebook.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 3.5.sp,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset("assets/images/facebook_f.png"),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          if(config.socialMediaLogin?.isTwitterEnabled == true)
                            ...[
                              Expanded(
                                child: Container(
                                  height: 6.h,
                                  width:  20.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff1D9BF0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppTags.continueWithTwitter.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 3.5.sp,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset("assets/images/twitter.png")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                        ],
                      ),
                    )
                  else
                    Column(
                      children: [
                        if(config.socialMediaLogin?.isGoogleEnabled == true)
                          ...[
                            InkWell(
                              onTap: () => authController.continueWithGoogle(),
                              child: Container(
                                height: 6.h,
                                width: 70.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xffE13F35),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppTags.continueWithGoogle.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset("assets/images/google_g.png"),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        if(config.socialMediaLogin?.isFacebookEnabled == true)
                          ...[
                            Container(
                              height: 6.h,
                              width: 70.w,
                              decoration: const BoxDecoration(
                                color: Color(0xff0777E8),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppTags.continueWithFacebook.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.asset("assets/images/facebook_f.png"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        if(config.socialMediaLogin?.isTwitterEnabled == true)
                          ...[
                            Container(
                              height: 6.h,
                              width: 70.w,
                              decoration: const BoxDecoration(
                                color: Color(0xff1D9BF0),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppTags.continueWithTwitter.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.asset("assets/images/twitter.png")
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                          ]
                      ],
                    ),
                  SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 0: 20),
                  TextButton(
                    onPressed: () {
                      navController.handleIndexChanged(2);
                      navController.selectedPage.value = "";
                      navController.clearAllHover();
                    },
                    child: Text(AppTags.alreadyHaveAnAccountSignIn.tr),
                  ),
                  SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 20: 80),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Something went wrong"),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () => SplashController().handleConfigData(),
                    child: const Text("Retry"),
                  )
                ],
              );
            }
          }
      ),
    );
  }

  signUp() async {
    if(authController.termsAndConditions.isFalse) {
      showShortToast(AppTags.pleaseAcceptTermsAndConditions.tr);
    }
    else if (_signUpFormKey.currentState!.validate()) {
      if(authController.passwordControllerSignup.text.length < 6) {
        showShortToast(AppTags.passwordShouldBe6CharactersLong.tr);
      } else if(isValidEmail(authController.emailControllerSignup.text)){
        String ipAddress = await SettingController().getIpAddress();
        String deviceId = await SettingController().getDeviceId();
        authController.signUp(ipAddress, deviceId);
      } else {
        showShortToast(AppTags.emailIsNotValidPleaseEnterValidEmail.tr);
      }
    }
  }
}
