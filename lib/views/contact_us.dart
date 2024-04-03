import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../controllers/user_controller.dart';
import '../utils/validators.dart';
import '../widgets/top_bar.dart';

class ContactUs extends StatelessWidget {
  ContactUs({super.key});
  final GlobalKey<FormState> _contactUsFormKey = GlobalKey<FormState>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (UserController controller) {
      return SafeArea(
        child: Column(
          children: [
            if(ResponsiveWidget.isSmallScreen(context))
              const TopBar(),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 20.w,
              ),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 14.w: 0),
                      child: Text(
                        AppTags.doYouHaveQuestionsWeHelpYouSolveThem.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "myFontLight",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF574667),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      AppTags.fillOutThisFormAndSomeoneFromOurTeamWillContact.tr,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFC0B4CC),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            if (ResponsiveWidget.isSmallScreen(context)) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _contactUsFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            validator: (String? value) {
                              return validateNotEmpty(value!, AppTags.firstName.tr);
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: AppTags.firstName.tr,
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
                        ), // First Name
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: userController.lastNameController,
                            validator: (String? value) {
                              return validateNotEmpty(value!, AppTags.lastName.tr);
                            },
                            textAlign: TextAlign.left,

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
                        ), // Last Name
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.emailController,
                      validator: (String? value) {
                        return validateNotEmpty(value!, AppTags.emailAddress.tr);
                      },
                      textAlign: TextAlign.left,
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
                    Row(
                      children: [
                        CountryCodePicker(
                          boxDecoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                          ),
                          onChanged: print,
                          initialSelection: 'PK',
                          favorite: ['+92','PK'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
                            textAlign: TextAlign.left,
                            validator: (String? value) {
                              return validateNotEmpty(value!, AppTags.phoneNumberHint.tr);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: AppTags.phoneNumberHint.tr,
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.messageController,
                      maxLines: 10,
                      textAlign: TextAlign.left,
                      validator: (String? value) {
                        return validateNotEmpty(value!, AppTags.writeAMessageHint.tr);
                      },
                      decoration: InputDecoration(
                        hintText: AppTags.writeAMessageHint.tr,
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
                    Image.asset(
                      "assets/images/map.png",
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => sendMessage(),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xff27B2CC),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
                        child: Text(
                          AppTags.send.tr,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ) else Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/images/map.png",
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ), // Map
                    const SizedBox(width: 16),
                    Expanded(
                      child: Form(
                        key: _contactUsFormKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.firstNameController,
                                    textAlign: TextAlign.center,
                                    validator: (String? value) {
                                      return validateNotEmpty(value!, AppTags.firstName.tr);
                                    },
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
                                ), // First Name
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.lastNameController,
                                    textAlign: TextAlign.center,
                                    validator: (String? value) {
                                      return validateNotEmpty(value!, AppTags.lastName.tr);
                                    },
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
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.emailController,
                              textAlign: TextAlign.center,
                              validator: (String? value) {
                                return validateNotEmpty(value!, AppTags.emailAddress.tr);
                              },
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
                            Row(
                              children: [
                                CountryCodePicker(
                                  boxDecoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: print,
                                  initialSelection: 'PK',
                                  favorite: ['+92','PK'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.phoneController,
                                    textAlign: TextAlign.center,
                                    validator: (String? value) {
                                      return validateNotEmpty(value!, AppTags.phoneNumberHint.tr);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: AppTags.phoneNumberHint.tr,
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
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.messageController,
                              maxLines: 10,
                              validator: (String? value) {
                                return validateNotEmpty(value!, AppTags.writeAMessageHint.tr);
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: AppTags.writeAMessageHint.tr,
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
                            InkWell(
                              onTap: () => sendMessage(),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xff27B2CC),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
                                child: Text(
                                  AppTags.send.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      );
    });
  }

  sendMessage() async {
    if (_contactUsFormKey.currentState!.validate()) {
      if(isValidEmail(userController.emailController.text)){
        userController.contactMessage();
      } else {
        showShortToast(AppTags.emailIsNotValidPleaseEnterValidEmail.tr);
      }
    }
  }

}
