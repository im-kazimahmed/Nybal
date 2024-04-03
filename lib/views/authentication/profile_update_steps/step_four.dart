import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/widgets/theme_data.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/update_profile_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/app_tags.dart';

class StepFour extends StatelessWidget {
  final UpdateProfileController controller;
  StepFour({super.key, required this.controller});
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            AppTags.aboutYou.tr,
            style: TextStyle(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTags.langSpeaks.tr,
                ),
                const SizedBox(height: 10),
                Autocomplete<String>(
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Material(
                        elevation: 4.0,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final dynamic option = options.elementAt(index);
                              return TextButton(
                                onPressed: () {
                                  onSelected(option);
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15.0,
                                    ),
                                    child: Text(
                                      '$option',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: AppColors.pinkButton,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return controller.langList.where((String option) {
                      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selectedLanguage) {
                    if (controller.langList.contains(selectedLanguage)) {
                      controller.tagController.addTag = selectedLanguage;
                    }
                  },
                  fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
                    return TextFieldTags(
                      textEditingController: ttec,
                      focusNode: tfn,
                      textfieldTagsController: controller.tagController,
                      textSeparators: const [' ', ','],
                      letterCase: LetterCase.normal,
                      validator: (String tag) {
                        if (controller.tagController.getTags!.contains(tag)) {
                          return 'you already entered that';
                        }
                        return null;
                      },
                      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
                        onSubmitted(value){
                          if(!controller.langList.contains(value)){
                            return;
                          }
                        }
                        return ((context, sc, tags, onTagDelete) {
                          return TextField(
                            controller: tec,
                            focusNode: fn,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.pinkButton,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.pinkButton,
                                  width: 2.0,
                                ),
                              ),
                              helperStyle: const TextStyle(
                                color: AppColors.pink,
                              ),
                              hintText: controller.tagController.hasTags ? '' : "Enter language name...",
                              hintStyle: const TextStyle(color: Colors.white),
                              errorText: error,
                              // prefixIconConstraints: BoxConstraints(maxWidth: Get.width * 0.74),
                              prefixIcon: tags.isNotEmpty ?
                              SingleChildScrollView(
                                controller: sc,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: AppColors.pink,
                                      ),
                                      margin: const EdgeInsets.only(right: 10.0),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 4.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              tag,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                255, 233, 233, 233,
                                              ),
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                              ): null,
                            ),
                            onChanged: (value) {
                              if(controller.langList.contains(value)) {
                                onChanged!;
                              }
                            },
                            onSubmitted: onSubmitted,
                          );
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                if(userController.userData.user != null && userController.userData.user?.gender == "Male")
                  ...[
                    Text(
                      AppTags.doYouHaveABeard.tr,
                    ),
                    const SizedBox(height: 10),
                    CustomDropDown(
                      selectedText: controller.selectedHaveBeard.value,
                      backgroundColor: const Color(0xFFF4F4F4),
                      selectedValueColor: controller.isHaveBeardSelected() ?
                      const Color(0xff000000): const Color(0xffC0B4CC),
                      onOptionChange: (value) => controller.onHaveBeardChange(value),
                      options: [AppTags.yes.tr, AppTags.no.tr],
                    ),
                  ]
                else
                  ...[
                    Text(
                      AppTags.doYouWearHijab.tr,
                    ),
                    const SizedBox(height: 10),
                    CustomDropDown(
                      selectedText: controller.selectedDoYouWearHijab.value,
                      backgroundColor: const Color(0xFFF4F4F4),
                      selectedValueColor: controller.isDoYouWearHijabSelected() ?
                      const Color(0xff000000): const Color(0xffC0B4CC),
                      onOptionChange: (value) => controller.onDoYouWearHijabChange(value),
                      options: [AppTags.yes.tr, AppTags.no.tr],
                    ),
                  ],
                const SizedBox(height: 20),
                Text(
                  AppTags.ethnicity.tr,
                ),
                const SizedBox(height: 10),
                CustomDropDown(
                  selectedText: controller.selectedEthnicity.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isEthnicitySelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onEthnicityChange(value),
                  options: [
                    AppTags.caucasianOrEuropean.tr,
                    AppTags.african.tr,
                    AppTags.africanAmericanBlack.tr,
                    AppTags.asian.tr,
                    AppTags.hispanicOrLatinx.tr,
                    AppTags.nativeAmericanOrIndigenous.tr,
                    AppTags.middleEastern.tr,
                    AppTags.pacificIslander.tr,
                    AppTags.southAsian.tr,
                    AppTags.southeastAsian.tr,
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  AppTags.financialStatus.tr,
                ),
                const SizedBox(height: 10),
                CustomDropDown(
                  selectedText: controller.selectedFinancialStatus.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isFinancialStatusSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onFinancialStatusChange(value),
                  options: [
                    AppTags.selfEmployed.tr, AppTags.governmentEmployee.tr,
                    AppTags.freelancer.tr, AppTags.generalEmployee.tr, AppTags.businessman.tr
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Date of birth",
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.dobController,
                  readOnly: true,
                  onTap: () {
                    controller.selectDate(context);
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter your date of birth',
                    hintStyle: const TextStyle(
                      color: Color(0xffC0B4CC),
                      fontSize: 13,
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
                Text(
                  AppTags.describeYourself.tr,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 15.h,
                  child: TextField(
                    expands: true,
                    maxLines:  null,
                    controller: controller.aboutMeController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: AppTags.tellUsAboutYourselfHint.tr,
                      hintStyle: const TextStyle(
                        color: Color(0xffC0B4CC),
                        overflow: TextOverflow.clip,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(fontSize: 12),
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppTags.specificationsOfYourPartnerThatYouWantToRelateTo.tr,
                  style: TextStyle(
                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 20.h,
                  child: TextField(
                    expands: true,
                    maxLines:  null,
                    controller: controller.partnerSpecsController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: AppTags.pleaseWriteInASeriousManner.tr,
                      hintStyle: const TextStyle(
                        color: Color(0xffC0B4CC),
                        overflow: TextOverflow.clip,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(fontSize: 12),
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppTags.yourSpecifications.tr,
                  style: TextStyle(
                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 20.h,
                  child: TextField(
                    expands: true,
                    maxLines:  null,
                    controller: controller.mySpecsController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: AppTags.pleaseWriteInASeriousManner.tr,
                      hintStyle: const TextStyle(
                        color: Color(0xffC0B4CC),
                        overflow: TextOverflow.clip,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(fontSize: 12),
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
