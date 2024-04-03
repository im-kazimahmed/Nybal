// import 'package:flutter/material.dart';
// import 'package:nybal/controllers/wife_reg_controller.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../Widgets/responsive_widget.dart';
//
// class StepSix extends StatelessWidget {
//   final WifeRegistrationController controller;
//   const StepSix({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         children: [
//           Text(
//             "Verification with selfie or pay a dollar",
//             style: TextStyle(
//               fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 5.sp,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           if (ResponsiveWidget.isSmallScreen(context)) Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.blue.withOpacity(0.4))
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(height: 50),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset("assets/images/camera2.png"),
//                           const SizedBox(width: 10),
//                           const Text(
//                             "Selfie photo",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 40),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset("assets/images/Picture.png"),
//                           const SizedBox(width: 10),
//                           const Text(
//                             "Take a photo",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xffCC1262),
//                               // fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 5.sp,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.blue.withOpacity(0.4))
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset("assets/images/checkbox.png"),
//                           const SizedBox(width: 10),
//                           const Expanded(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "Verify by phone number",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     // fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 5.sp,
//
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.blue.withOpacity(0.4)),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Pay",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: '\$',
//                               style: TextStyle(
//                                 color: Color(0xffCC1262),
//                                 fontWeight: FontWeight.w300,
//                                 fontSize: 22.sp,
//                               ),
//                             ),
//                             TextSpan(
//                               text: '1',
//                               style: TextStyle(
//                                 color: const Color(0xffCC1262),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 22.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ) else Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 30.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.blue.withOpacity(0.4)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("assets/images/camera2.png"),
//                             const SizedBox(width: 10),
//                             Text(
//                               "Selfie photo",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 4.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("assets/images/Picture.png"),
//                             const SizedBox(width: 10),
//                             Text(
//                               "Take a photo",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color(0xffCC1262),
//                                 fontSize: 4.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Container(
//                     height: 30.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.blue.withOpacity(0.4)),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 1.w),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("assets/images/checkbox.png"),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     "Verify by phone number",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 4.sp,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Container(
//                     height: 30.h,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: Colors.blue.withOpacity(0.4))
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Pay",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 5.sp,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: '\$',
//                                 style: TextStyle(
//                                   color: const Color(0xffCC1262),
//                                   fontWeight: FontWeight.w300,
//                                   fontSize: 10.sp,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: '1',
//                                 style: TextStyle(
//                                   color: const Color(0xffCC1262),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 10.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),
//           InkWell(
//             onTap: () {
//
//             },
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Color(0xff27B2CC),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
//               child: const Text(
//                 'Confirm',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
