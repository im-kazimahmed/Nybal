import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/helpers/local_data_helper.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/views/members/wish_to_marry_members.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/theme_data.dart';
import '../../controllers/navigation_controller.dart';

class FooterView extends StatelessWidget {
  FooterView({super.key});
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffF0DCFD),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      AppTags.membersList.tr,
                      style: const TextStyle(
                        color: AppColors.pinkButton,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => LocalDataHelper().getUserToken() != null ?
                      navController.handleNavIndexChanged(15): navController.handleIndexChanged(8),
                      child: Row(
                        children: [
                          Text(AppTags.allWhoWishToMarry.tr),
                          const SizedBox(width: 5,),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.pinkButton,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => LocalDataHelper().getUserToken() != null ?
                      navController.handleNavIndexChanged(19): navController.handleIndexChanged(1),
                      child: Row(
                        children: [
                          Text(AppTags.advancedSearch.tr),
                          const SizedBox(width: 5,),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.pinkButton,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => LocalDataHelper().getUserToken() != null ?
                      navController.handleNavIndexChanged(17): navController.handleIndexChanged(5),
                      child: Row(
                        children: [
                          Text(AppTags.online.tr),
                          const SizedBox(width: 5,),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.pinkButton,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 50),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      AppTags.technicalSupport.tr,
                      style: const TextStyle(
                        color: AppColors.pinkButton,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(AppTags.help.tr),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(AppTags.siteTermsAndConditions.tr),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(AppTags.privacyPolicy.tr),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(AppTags.cookiePolicy.tr),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      AppTags.whoAreWe.tr,
                      style: const TextStyle(
                        color: AppColors.pinkButton,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          AppTags.aboutUs.tr,
                        ),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(AppTags.downloadTheApp.tr),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(AppTags.loveBlog.tr),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => LocalDataHelper().getUserToken() != null ?
                      navController.handleNavIndexChanged(16): navController.handleIndexChanged(0),
                      child: Row(
                        children: [
                          Text(AppTags.subscription.tr),
                          const SizedBox(width: 5),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.pinkButton,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(AppTags.successfulStories.tr),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.pinkButton,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                    InkWell(
                      // onTap: () => navController.handleIndexChanged(6),
                      onTap: () => LocalDataHelper().getUserToken() != null ?
                      navController.handleNavIndexChanged(14): navController.handleIndexChanged(6),
                      child: Row(
                        children: [
                          Text(AppTags.faq.tr),
                          const SizedBox(width: 5),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.pinkButton,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 20),
          FittedBox(
            child: Column(
              children: [
                Image.asset("assets/images/iconMain.png",
                  height: 15.h,
                  width: 15.w,
                ),
                const SizedBox(height: 10),
                _buildSocialIcons(),
                const SizedBox(height: 10),
                const Text(
                  "@Nybal_zawaj.",
                  style: TextStyle(
                    color: Color(0xffCC1262),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/images/youtube.png",
            color: const Color(0xFF27B2CC),
            height: 20.0,
            width: 20.0,
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/images/twitter.png",
            color: const Color(0xFF27B2CC),
            height: 20.0,
            width: 20.0,
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/images/facebook_f.png",
            color: const Color(0xFF27B2CC),
            height: 20.0,
            width: 20.0,
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/images/instagram.png",
            color: const Color(0xFF27B2CC),
            height: 20.0,
            width: 20.0,
          ),
        ),
      ],
    );
  }

}
