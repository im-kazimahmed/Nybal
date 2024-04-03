import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/language_controller.dart';
import 'package:nybal/views/web_views/actionsBar.dart';
import 'package:nybal/views/web_views/footer.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../Widgets/theme_data.dart';
import '../../utils/app_tags.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_responsive.dart';
import '../../widgets/top_bar.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final AuthController authController = Get.find<AuthController>();
  final UserController userController = Get.find<UserController>();
  final LanguageController langController = Get.find<LanguageController>();
  final GlobalKey<FormState> _verificationFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(authController.isVerifyLater.isTrue) {
      authController.resendEmail(
        userId: userController.userData.user!.id!,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomResponsive(
      topNavigation: [
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
            color: AppColors.appBarPurple,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: langController.languages.map((lang){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: InkWell(
                    onTap: () {
                      langController.updateLocale(lang.key);
                    },
                    child: Text(
                      "${lang.name}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
      topNavigationAlignment: MainAxisAlignment.center,
      drawerWidget: const Drawer(),
      actionsWidget: <Widget>[
        ActionsBarWidget()
      ],
      actionsAlignment: MainAxisAlignment.end,
      bodyContent: SafeArea(
        child: Column(
          children: [
            if(ResponsiveWidget.isSmallScreen(context))
              const TopBar(),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 20.w),
              child: Form(
                key: _verificationFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      AppTags.verification.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "myFontLight",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF574667),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppTags.otp.tr,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF574667),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: authController.otpController,
                      textAlign: TextAlign.center,
                      validator: (String? value) {
                        return validateNotEmpty(value!, AppTags.otp.tr);
                      },
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: AppTags.enterOTPHint.tr,
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
                    const SizedBox(height: 30),
                    InkWell(
                      // onTap:() {
                      //   print(userController.userData.userData?.toJson());
                      //   print(userController.userData.userPackage?.toJson());
                      //   userController.userData.packagePermissions?.forEach((element) {
                      //     print(element.toJson());
                      //   });
                      // },
                      onTap: () => verify(),
                      child: Container(
                        height: 6.h,
                        width: !ResponsiveWidget.isSmallScreen(context) ? 20.w: 50.w,
                        decoration: const BoxDecoration(
                          color: Color(0xff27B2CC),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: !ResponsiveWidget.isSmallScreen(context) ? 0: 10.w, vertical: 0.0),
                        child: Text(
                          AppTags.verify.tr,
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
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                authController.resendEmail(
                  userId: userController.userData.user!.id!,
                );
              },
              child: Text(AppTags.didNotReceivedTheCodeResend.tr),
            ),
            SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 20: 80),
          ],
        ),
      ),
      footerContent: FooterView(),
      enableChatSupport: false,
    );
  }

  verify() {
    if (_verificationFormKey.currentState!.validate()) {
      if(!authController.otpController.text.isNumericOnly) {
        showShortToast(AppTags.invalidOTP.tr);
      } else {
        authController.otpVerification(
          userId: userController.userData.user!.id!,
          otp: authController.otpController.text,
        );
      }
    }
  }
}
