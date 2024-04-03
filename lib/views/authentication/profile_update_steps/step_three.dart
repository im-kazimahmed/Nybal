import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nybal/models/religion_model.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/widgets/model_drop_down.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/setting_controller.dart';
import '../../../controllers/update_profile_controller.dart';
import '../../../models/config_model.dart';

class StepThree extends StatelessWidget {
  final UpdateProfileController controller;
  StepThree({super.key, required this.controller});
  final SettingController settingController = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            AppTags.religiousCommitment.tr,
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
                  AppTags.areYouReligious.tr,
                ),
                const SizedBox(height: 10),
                CustomDropDown(
                  selectedText: controller.selectedAreYouReligious.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isAreYouReligiousSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onAreYouReligiousChange(value),
                  options: [AppTags.yes.tr, AppTags.no.tr],
                ),
                const SizedBox(height: 20),
                if(controller.selectedAreYouReligious.value == AppTags.yes.tr)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTags.selectReligion.tr,
                      ),
                      const SizedBox(height: 10),
                      CustomModelDropDown<ReligionModel>(
                        backgroundColor: const Color(0xFFF4F4F4),
                        options: controller.religions,
                        onOptionChange: (selectedReligion) => controller.onReligionChange(selectedReligion),
                        selectedValueColor: controller.isReligionSelected() ?
                        const Color(0xff000000): const Color(0xffC0B4CC),
                        optionLabel: (religion) => religion.name!,
                        selectedValue: controller.selectedReligion,
                        isArrowOnLeft: false,
                        arrowIcon: Icons.keyboard_arrow_down,
                      ),
                      if(controller.isReligionSelected())
                        ...[
                          const SizedBox(height: 20),
                          Text(
                            AppTags.selectSubReligion.tr,
                          ),
                          const SizedBox(height: 10),
                          CustomModelDropDown<ReligionModel>(
                            backgroundColor: const Color(0xFFF4F4F4),
                            options: controller.subReligions,
                            onOptionChange: (selectedReligion) => controller.onSubReligionChange(selectedReligion),
                            selectedValueColor: controller.isSubReligionSelected() ?
                            const Color(0xff000000): const Color(0xffC0B4CC),
                            optionLabel: (religion) => religion.name!,
                            selectedValue: controller.selectedSubReligion,
                            isArrowOnLeft: false,
                            arrowIcon: Icons.keyboard_arrow_down,
                          ),
                        ],
                      const SizedBox(height: 20),
                      Text(
                        AppTags.doYouPray.tr,
                      ),
                      const SizedBox(height: 10),
                      CustomDropDown(
                        selectedText: controller.selectedDoYouPray.value,
                        backgroundColor: const Color(0xFFF4F4F4),
                        selectedValueColor: controller.isDoYouPraySelected() ?
                        const Color(0xff000000): const Color(0xffC0B4CC),
                        onOptionChange: (value) => controller.onDoYouPrayChange(value),
                        options: [AppTags.yes.tr, AppTags.no.tr],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                Text(
                  AppTags.doYouSmoke.tr,
                ),
                const SizedBox(height: 10),
                CustomDropDown(
                  selectedText: controller.selectedDoYouSmoke.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isDoYouSmokeSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onDoYouSmokeChange(value),
                  options: [AppTags.yes.tr, AppTags.no.tr],
                ),
                const SizedBox(height: 20),
                Text(
                  AppTags.willingToRelocate.tr,
                ),
                const SizedBox(height: 10),
                CustomDropDown(
                  selectedText: controller.selectedWillingToRelocate.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isWillingToRelocateSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onWillingToRelocateChange(value),
                  options: [AppTags.yes.tr, AppTags.no.tr],
                ),
                const SizedBox(height: 20),
                Text(
                  AppTags.maritalStatus.tr,
                ),
                const SizedBox(height: 10),
                CustomDropDown(
                  selectedText: controller.selectedMaritalStatus.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isMaritalStatusSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onMaritalStatusChange(value),
                  options: [AppTags.single.tr, AppTags.married.tr, AppTags.divorced.tr],
                ),
                if(controller.selectedMaritalStatus.value == AppTags.married.tr ||
                    controller.selectedMaritalStatus.value == AppTags.divorced.tr)
                  ...[
                    const SizedBox(height: 20),
                    Text(
                      AppTags.children.tr,
                    ),
                    const SizedBox(height: 10),
                    CustomDropDown(
                      selectedText: controller.selectedChildren.value,
                      backgroundColor: const Color(0xFFF4F4F4),
                      selectedValueColor: controller.isChildrenSelected() ?
                      const Color(0xff000000): const Color(0xffC0B4CC),
                      onOptionChange: (value) => controller.onChildrenChange(value),
                      options: const ["None", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10 or More"],
                    ),
                  ]
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppTags.studyAndWork.tr,
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
                  AppTags.education.tr,
                ),
                const SizedBox(height: 10),
                if(settingController.educationsList.isNotEmpty)
                  CustomModelDropDown<Educations>(
                    backgroundColor: const Color(0xFFF4F4F4),
                    options: settingController.educationsList,
                    onOptionChange: (selectedEducation) => controller.onEducationChange(selectedEducation),
                    selectedValueColor: controller.isEducationSelected() ?
                    const Color(0xff000000): const Color(0xffC0B4CC),
                    optionLabel: (education) => education.title!,
                    selectedValue: controller.selectedEducation,
                    isArrowOnLeft: false,
                    arrowIcon: Icons.keyboard_arrow_down,
                  ),
                const SizedBox(height: 20),
                Text(
                  AppTags.doYouHaveAJob.tr,
                ),
                const SizedBox(height: 10),
                CustomDropDown(
                  selectedText: controller.selectedHaveJob.value,
                  backgroundColor: const Color(0xFFF4F4F4),
                  selectedValueColor: controller.isHaveJobSelected() ?
                  const Color(0xff000000): const Color(0xffC0B4CC),
                  onOptionChange: (value) => controller.onHaveJobChange(value),
                  options: [AppTags.yes.tr, AppTags.no.tr],
                ),
                const SizedBox(height: 20),
                if(controller.selectedHaveJob.value == AppTags.yes.tr)
                  TextField(
                    controller: controller.salaryController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppTags.enterSalaryAmount.tr,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
