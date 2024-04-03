import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:nybal/routes/routes.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
            image: const AssetImage(
              "assets/images/bg.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 8,
            ),
            SizedBox(
              height: Get.height / 6,
              width: Get.height / 6,
              child: const Image(image: AssetImage("assets/images/logo.png")),
            ),
            SizedBox(height: Get.height / 14),
            const Text(
              "Nybal.com\nFor Islamic Dating",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "myFontBold",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              "The right place to meet your other half",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "myFontLight",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffe4e3e4)),
            ),
            const SizedBox(height: 70),
            GestureDetector(
              onTap: () {
                // Get.to(()=>home_Page());
                // Get.to(()=>const TestScreen());
              },
              child: SizerUtil.deviceType == DeviceType.mobile ?
                Container(
                  alignment: Alignment.center,
                  height: Get.height / 12,
                  width: Get.width / 1.2,
                  child: Image(
                    height: Get.height / 12,
                    width: Get.width / 1.2,
                    image: const AssetImage(
                      "assets/images/fb.png",
                    ),
                    fit: BoxFit.cover,
                  )):
                Expanded(
                  child: Container(
                  alignment: Alignment.center,
                  height: 10.h,
                  child: Image(
                    height: 10.h,
                    image: const AssetImage(
                      "assets/images/fb.png",
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
            ),
            if(SizerUtil.deviceType == DeviceType.mobile)
              GestureDetector(
                onTap: () {
                  // Get.offAllNamed(Routes.homeScreen);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height / 12,
                  width: Get.width / 1.2,
                  child: Image(
                    height: Get.height / 12,
                    width: Get.width / 1.2,
                    image: const AssetImage(
                      "assets/images/google.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () {
                  // Get.to(()=>  home_Page());
                },
                child: Expanded(
                  child: Image(
                    height: 10.h,
                    image: const AssetImage(
                      "assets/images/google.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(()=> const SignUpPageWeb());
            //   },
            //   child: Container(
            //       alignment: Alignment.center,
            //       height: Get.height / 16.5,
            //       width: Get.width / 1.23,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(30.0),
            //       ),
            //       child: const Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 13.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Icon(Icons.email),
            //             Text("Continue with email"),
            //             SizedBox(),
            //           ],
            //         ),
            //       ))
            // ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "myFontLight",
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.signIn);
                  },
                  child: const Text(
                    " Sign in",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "myFontBold",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        width: Get.width,
        height: Get.height * 0.06,
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Privacy Policy",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "myFontLight",
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xffe4e3e4)),
            ),
            SizedBox(width: 05),
            Text(
              "•",
              style: TextStyle(
                  fontFamily: "myFontBold",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffe4e3e4)),
            ),
            SizedBox(width: 05),
            Text(
              "Terms of Use",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "myFontLight",
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xffe4e3e4)),
            ),
          ],
        ),
      ),
    );
  }
}
