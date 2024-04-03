import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/controllers/support_controller.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/widgets/responsive_widget.dart';
import 'package:nybal/widgets/top_bar.dart';

class CreateTicket extends StatelessWidget {
  CreateTicket({super.key});
  final navController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<SupportSystemController>(builder: (SupportSystemController controller) {
          return WillPopScope(
            onWillPop: () async {
              navController.handleNavIndexChanged(navController.previousIndex.value);
              return false;
            },
            child: SafeArea(
              child: Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  Text(
                    'Create new ticket',
                    style: TextStyle(
                      fontSize: ResponsiveWidget.isSmallScreen(context) ? 18: 20,
                      fontFamily: "myFontLight",
                      fontWeight: FontWeight.bold,
                      color: themeController.isDarkMode.isTrue ?
                      Colors.white: const Color(0xFF574667),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: controller.titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Are you having the problem with?',
                            border: const OutlineInputBorder(),
                            hintStyle: TextStyle(
                              color: themeController.isDarkMode.isTrue ?
                              Colors.white: null,
                            ),
                            labelStyle: TextStyle(
                                color: themeController.isDarkMode.isTrue ?
                                Colors.white: null,
                            ),
                          ),
                          style: TextStyle(
                            color: themeController.isDarkMode.isTrue ?
                            Colors.white: null,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          controller: controller.descriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Tell us what is happening in detail',
                            border: const OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: themeController.isDarkMode.isTrue ?
                              Colors.white: null,
                            ),
                          ),
                          style: TextStyle(
                            color: themeController.isDarkMode.isTrue ?
                            Colors.white: null,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        DropdownButton(
                          value: controller.valueType,
                          dropdownColor: themeController.isDarkMode.isTrue ?
                          Colors.white: null,
                          items: controller.types.map((String type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: themeController.isDarkMode.isTrue ?
                                  Colors.white: null,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? selected) {
                            // _valueType = selected;
                            // setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () => controller.insertTicket(),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.pinkButton,
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(12.0),
                                  child: const Text(
                                    'Submit ticket',
                                    style: TextStyle(color: AppColors.whiteColor, fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        );
      }
    );
  }
}
