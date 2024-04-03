import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/dialogs.dart';
import 'package:nybal/controllers/splash_controller.dart';
import 'package:nybal/models/config_model.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/user_controller.dart';
import '../../Widgets/theme_data.dart';
import '../../utils/validators.dart';
import '../../widgets/top_bar.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final navController = Get.find<NavigationController>();
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();
  final LanguageController langController = Get.find<LanguageController>();
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<ConfigModel>(
          future: SplashController().handleConfigData(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoader());
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
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          Text(
                            AppTags.signIn.tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "myFontLight",
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF574667),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            AppTags.emailAddress.tr,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF574667),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: authController.emailController,
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
                            controller: authController.passwordController,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppTags.forgotYourPassword.tr,
                                style: const TextStyle(
                                  color: Color(0xffC0B4CC),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppTags.incognitoMode.tr,
                                    style: const TextStyle(
                                      color: Color(0xffC0B4CC),
                                    ),
                                  ),
                                  Obx(()=> Checkbox(
                                    activeColor: Colors.deepPurple,
                                    side: const BorderSide(color: AppColors.pinkButton),
                                    value: authController.isIncognito.value,
                                    onChanged: (value) {
                                      authController.isIncognitoUpdate(value);
                                    },
                                  ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () => login(),
                            child: Container(
                              height: 6.h,
                              width: !ResponsiveWidget.isSmallScreen(context) ? 20.w: 70.w,
                              decoration: const BoxDecoration(
                                color: Color(0xff27B2CC),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: !ResponsiveWidget.isSmallScreen(context) ? 0: 10.w, vertical: 0.0),
                              child: Text(
                                AppTags.access.tr,
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
                  if (!ResponsiveWidget.isSmallScreen(context)) Padding(
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
                              child: InkWell(
                                onTap: () => authController.signUpWithTwitter(),
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
                            ),
                            const SizedBox(width: 10),
                          ],
                      ],
                    ),
                  ) else Column(
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
                          InkWell(
                            // onTap: () => authController.signUpWithTwitter(),
                            child: Container(
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
                          ),
                        ],
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      navController.handleIndexChanged(9);
                      navController.selectedPage.value = "";
                      navController.clearAllHover();
                    },
                    child: Text(AppTags.doNotHaveAnAccountSignUp.tr),
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
                    onPressed: () {
                      SplashController().handleConfigData();
                      navController.handleIndexChanged(2);
                    },
                    child: const Text("Retry")
                  )
                ],
              );
            }
          },
      ),
    );
  }

  void login() async {
    if (_signInFormKey.currentState!.validate()) {
      if(authController.passwordController.text.length < 6) {
        showShortToast(AppTags.passwordShouldBe6CharactersLong.tr);
      } else if(isValidEmail(authController.emailController.text)){
        String ip = await SettingController().getIpAddress();
        authController.loginWithEmailPassword(
          ipAdd: ip,
          email: authController.emailController.text,
          password: authController.passwordController.text,
        );
      } else {
        showShortToast(AppTags.emailIsNotValidPleaseEnterValidEmail.tr);
      }
    }
  }
}
