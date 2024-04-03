import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/wife_reg_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/widgets/dialogs.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/custom_drop_down.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../models/country_model.dart';
import '../../../widgets/model_drop_down.dart';

class StepTwo extends StatelessWidget {
  final WifeRegistrationController controller;
  const StepTwo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getCountriesList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoader();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  "Naturalization and Residency",
                  style: TextStyle(
                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomModelDropDown<CountryModel>(
                        backgroundColor: const Color(0xFFF4F4F4),
                        options: controller.countries,
                        onOptionChange: (selectedCountry) => controller.onCountryChange(selectedCountry),
                        selectedValueColor: controller.isCountrySelected() ?
                        const Color(0xff000000): const Color(0xffC0B4CC),
                        optionLabel: (country) => country.name!,
                        selectedValue: controller.selectedCountry,
                        isArrowOnLeft: true,
                        arrowIcon: Icons.arrow_downward,
                        arrowColor: const Color(0xffCC1262),
                      ),
                      const SizedBox(height: 20),
                      if(controller.isCountrySelected())
                        CustomModelDropDown<StateModel>(
                          backgroundColor: const Color(0xFFF4F4F4),
                          options: controller.statesByCountry,
                          onOptionChange: (selectedState) => controller.onStateChange(selectedState),
                          selectedValueColor: controller.isStateAndCountrySelected() ?
                          const Color(0xff000000): const Color(0xffC0B4CC),
                          optionLabel: (state) => state.name!,
                          selectedValue: controller.selectedState,
                          isArrowOnLeft: true,
                          arrowIcon: Icons.arrow_downward,
                          arrowColor: const Color(0xffCC1262),
                        ),
                      const SizedBox(height: 20),
                      if(controller.isStateAndCountrySelected())
                        CustomModelDropDown<CityModel>(
                          backgroundColor: const Color(0xFFF4F4F4),
                          options: controller.citiesByState,
                          onOptionChange: (selectedCity) => controller.onCityChange(selectedCity),
                          selectedValueColor: controller.isCitySelected() ?
                          const Color(0xff000000): const Color(0xffC0B4CC),
                          optionLabel: (city) => city.name!,
                          selectedValue: controller.selectedCity,
                          isArrowOnLeft: true,
                          arrowIcon: Icons.arrow_downward,
                          arrowColor: const Color(0xffCC1262),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Partner Specifications",
                  style: TextStyle(
                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      CustomDropDown(
                        selectedText: controller.selectedHeight.value,
                        backgroundColor: const Color(0xFFF4F4F4),
                        selectedValueColor: controller.isHeightSelected() ?
                        const Color(0xff000000): const Color(0xffC0B4CC),
                        onOptionChange: (height) => controller.onHeightChange(height),
                        options: controller.heightOptions,
                      ),
                      const SizedBox(height: 20),
                      CustomDropDown(
                        // selectedText: "Choose Partner's Weight (kg)",
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

        }
      }
    );
  }
}
