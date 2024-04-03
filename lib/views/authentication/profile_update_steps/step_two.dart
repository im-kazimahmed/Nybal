import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/update_profile_controller.dart';
import '../../../models/country_model.dart';
import '../../../utils/app_tags.dart';
import '../../../widgets/model_drop_down.dart';

class StepTwo extends StatelessWidget {
  final UpdateProfileController controller;
  const StepTwo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProfileController>(builder: (UpdateProfileController controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Text(
              AppTags.naturalizationAndResidency.tr,
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
                    AppTags.nationality.tr,
                  ),
                  const SizedBox(height: 10),
                  CustomModelDropDown<CountryModel>(
                    backgroundColor: const Color(0xFFF4F4F4),
                    options: controller.countries,
                    onOptionChange: (selectedCountry) => controller.onNationalityChange(selectedCountry),
                    selectedValueColor: controller.isNationalitySelected() ?
                      const Color(0xff000000): const Color(0xffC0B4CC),
                    optionLabel: (country) => country.name!,
                    selectedValue: controller.selectedNationality,
                    isArrowOnLeft: false,
                    arrowIcon: Icons.keyboard_arrow_down,
                  ),
                ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTags.height.tr,
                  ),
                  const SizedBox(height: 10),
                  CustomDropDown(
                    selectedText: controller.selectedHeight.value,
                    backgroundColor: const Color(0xFFF4F4F4),
                    selectedValueColor: controller.isHeightSelected() ?
                    const Color(0xff000000): const Color(0xffC0B4CC),
                    onOptionChange: (height) => controller.onHeightChange(height),
                    options: controller.heightOptions,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppTags.weight.tr,
                  ),
                  const SizedBox(height: 10),
                  CustomDropDown(
                    selectedText: controller.selectedWeight.value,
                    backgroundColor: const Color(0xFFF4F4F4),
                    selectedValueColor: controller.isWeightSelected() ?
                    const Color(0xff000000): const Color(0xffC0B4CC),
                    onOptionChange: (weight) => controller.onWeightChange(weight),
                    options: const ["20 (kg)", "30 (kg)", "40 (kg)", "50 (kg)",
                      "60 (kg)", "70 (kg)", "80 (kg)", "90 (kg)", "100 (kg)",
                      "110 (kg)", "120 (kg)", "130 (kg)"],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppTags.physicalCondition.tr,
                  ),
                  const SizedBox(height: 10),
                  CustomDropDown(
                    selectedText: controller.selectedPhysicalCondition.value,
                    backgroundColor: const Color(0xFFF4F4F4),
                    selectedValueColor: controller.isPhysicalConditionSelected() ?
                    const Color(0xff000000): const Color(0xffC0B4CC),
                    onOptionChange: (value) => controller.onPhysicalConditionChange(value),
                    options: [AppTags.fat.tr, AppTags.smart.tr, AppTags.skinny.tr, AppTags.healthy.tr],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppTags.skinColor.tr,
                  ),
                  const SizedBox(height: 10),
                  CustomDropDown(
                    selectedText: controller.selectedSkinColor.value,
                    backgroundColor: const Color(0xFFF4F4F4),
                    selectedValueColor: controller.isSkinColorSelected() ?
                    const Color(0xff000000): const Color(0xffC0B4CC),
                    onOptionChange: (value) => controller.onSkinColorChange(value),
                    options: [AppTags.white.tr, AppTags.fair.tr, AppTags.black.tr],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
    });

  }
}
