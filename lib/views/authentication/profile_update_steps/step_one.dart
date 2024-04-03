import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/dialogs.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/update_profile_controller.dart';
import '../../../models/country_model.dart';
import '../../../widgets/model_drop_down.dart';

class StepOne extends StatelessWidget {
  final UpdateProfileController controller;
  const StepOne({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProfileController>(builder: (UpdateProfileController controller) {
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 4.w),
                    child: Text(
                      AppTags.beforeWeProceedFurtherLetUsKnowYourResidence.tr,
                      style: TextStyle(
                        fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.sp: 5.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTags.selectCountry.tr,
                        ),
                        const SizedBox(height: 10),
                        CustomModelDropDown<CountryModel>(
                          backgroundColor: const Color(0xFFF4F4F4),
                          options: controller.countries,
                          onOptionChange: (selectedCountry) => controller.onCountryChange(selectedCountry),
                          selectedValueColor: controller.isCountrySelected() ?
                            const Color(0xff000000): const Color(0xffC0B4CC),
                          optionLabel: (country) => country.name!,
                          selectedValue: controller.selectedCountry,
                          isArrowOnLeft: false,
                          arrowIcon: Icons.keyboard_arrow_down,
                        ),
                        if(controller.isCountrySelected())
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                AppTags.selectState.tr,
                              ),
                              const SizedBox(height: 10),
                              CustomModelDropDown<StateModel>(
                                backgroundColor: const Color(0xFFF4F4F4),
                                options: controller.statesByCountry,
                                onOptionChange: (selectedState) => controller.onStateChange(selectedState),
                                selectedValueColor: controller.isStateAndCountrySelected() ?
                                const Color(0xff000000): const Color(0xffC0B4CC),
                                optionLabel: (state) => state.name!,
                                selectedValue: controller.selectedState,
                                isArrowOnLeft: false,
                                arrowIcon: Icons.keyboard_arrow_down,
                              ),
                            ],
                          )
                        else
                          const SizedBox(height: 20),
                        if(controller.isStateAndCountrySelected())
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                AppTags.selectCity.tr,
                              ),
                              const SizedBox(height: 10),
                              CustomModelDropDown<CityModel>(
                                backgroundColor: const Color(0xFFF4F4F4),
                                options: controller.citiesByState,
                                onOptionChange: (selectedCity) => controller.onCityChange(selectedCity),
                                selectedValueColor: controller.isCitySelected() ?
                                const Color(0xff000000): const Color(0xffC0B4CC),
                                optionLabel: (city) => city.name!,
                                selectedValue: controller.selectedCity,
                                isArrowOnLeft: false,
                                arrowIcon: Icons.keyboard_arrow_down,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ); // Replace this with your actual widget.
          }
        },
      );
    });
  }
}
