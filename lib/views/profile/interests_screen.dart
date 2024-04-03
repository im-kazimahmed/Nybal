import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/interest_model.dart';
import 'package:nybal/widgets/dialogs.dart';
import 'package:nybal/widgets/responsive_widget.dart';
import 'package:nybal/widgets/top_bar.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});
  // final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(builder: (UserController controller) {
        return FutureBuilder<List<InterestModel>?>(
          future: controller.getInterestsList(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoader());
            } else if(snapshot.hasData) {
              List<InterestModel>? interests = snapshot.data;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    children: [
                      if(ResponsiveWidget.isSmallScreen(context))
                        const TopBar(),
                      if(interests != null)
                        Column(
                          children: [
                            const Text(
                              "Select Interests",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: "myFontLight",
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFC0B4CC),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: interests.length,
                              itemBuilder: (context, index) {
                                return Obx(()=>
                                  InkWell(
                                    onTap: () {
                                      controller.onInterestTap(interests[index]);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.200,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: controller.isInterestSelected(interests[index]) ?
                                        AppColors.pinkButton: null,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '🎨 ${interests[index].title}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21,
                                            color: controller.isInterestSelected(interests[index]) ?
                                            AppColors.whiteColor: null,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Obx(()=>
                                InkWell(
                                  onTap: !controller.isInterestEmpty() ? () {
                                    controller.saveUserInterests();
                                  }: null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: controller.isInterestEmpty() ? Colors.grey: AppColors.pinkButton,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                                    margin: const EdgeInsets.only(bottom: 30),
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return const Align(
                alignment: Alignment.center,
                child: Text("Something went wrong"),
              );
            }

          },
        );
      }
      ),
    );
  }
}
