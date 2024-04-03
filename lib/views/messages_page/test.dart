// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/chat_controller.dart';
// import '../../../Widgets/theme_data.dart';
// import '../../../Widgets/full_screen_image.dart';
// import '../../profile_view/profile_View_Page.dart';
// import '../Video_Call/video_call.dart';
//
// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ChatController>(builder: (ChatController controller) {
//       return Scaffold(
//         backgroundColor: const Color(0xfffbf5f5),
//         appBar: AppBar(
//           elevation: 0,
//           forceMaterialTransparency: true,
//           systemOverlayStyle: const SystemUiOverlayStyle(
//             statusBarBrightness: Brightness.dark,
//             statusBarColor: Colors.transparent,
//           ),
//           excludeHeaderSemantics: true,
//           backgroundColor: const Color(0xfffbf5f5),
//           title: SizedBox(
//             height: 53,
//             child: Center(
//               child: Card(
//                   elevation: 1,
//                   margin: const EdgeInsets.only(top: 2),
//                   child: Container(
//                     height: Get.height / 12,
//                     width: Get.width / 1.2,
//                     color: Colors.white,
//                     child: Row(children: [
//                       const SizedBox(width: 05),
//                       GestureDetector(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: const Icon(
//                           Icons.close,
//                           color: Color(0xFFC0B4CC),
//                         ),
//                       ),
//                       const SizedBox(width: 05),
//                       const Text(
//                         "—",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFFC0B4CC),
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       GestureDetector(
//                         onTap: () {},
//                         child: const SizedBox(
//                           height: 25,
//                           width: 25,
//                           child: Image(
//                             image: AssetImage("assets/images/green_call.png"),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(()=> const videoCall());
//                         },
//                         child: const SizedBox(
//                           height: 25,
//                           width: 25,
//                           child: Image(
//                               image: AssetImage("assets/images/green_vdo.png")),
//                         ),
//                       ),
//                       const Spacer(),
//                       const SizedBox(
//                         height: 25,
//                         width: 25,
//                         child: Image(image: AssetImage("assets/images/flag.png")),
//                       ),
//                       const SizedBox(width: 05),
//                       const Text(
//                         "Farida",
//                         style: TextStyle(
//                           fontSize: 16,
//                           overflow: TextOverflow.ellipsis,
//                           fontWeight: FontWeight.w700,
//                           fontFamily: "myFontLight",
//                           color: Color(0xFF574667),
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           GestureDetector(
//                             onTap: () => Get.to(()=> const ProfileViewPage()),
//                             child: const CircleAvatar(
//                               radius: 20,
//                               backgroundImage: AssetImage("assets/images/profile.png"),
//                             ),
//                           ),
//                           const Positioned(
//                             bottom: -02,
//                             right: -02,
//                             child: CircleAvatar(
//                               radius: 08,
//                               backgroundColor: Colors.white, // Color(0xFFffb800),
//                               child: CircleAvatar(
//                                 radius: 03,
//                                 backgroundColor: Color(0xFF2ECC24),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       const Icon(Icons.more_vert, color: Color(0xFFC0B4CC)),
//                     ]),
//                   )),
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//                 flex: 9,
//                 child: SizedBox(
//                   // height: Get.height / 1.4,
//                     width: Get.width / 1.2,
//                     // color: Colors.red,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           // Container(
//                           //   width: Get.width / 1.1,
//                           //   child: Row(
//                           //     mainAxisAlignment: MainAxisAlignment.center,
//                           //     crossAxisAlignment: CrossAxisAlignment.center,
//                           //     children: [
//                           //       Container(
//                           //         height: 1,
//                           //         width: Get.width / 4,
//                           //         color: Color(0xFFC0B4CC),
//                           //       ),
//                           //       SizedBox(width: 10),
//                           //       Text(
//                           //         "Today",
//                           //         style: TextStyle(color: Color(0xFFC0B4CC)),
//                           //       ),
//                           //       SizedBox(width: 10),
//                           //       Container(
//                           //         height: 1,
//                           //         width: Get.width / 4,
//                           //         color: Color(0xFFC0B4CC),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
//                           // SizedBox(height: 20),
//                           // Text(
//                           //   "09:34 PM",
//                           //   style: TextStyle(color: Color(0xFFC0B4CC)),
//                           // ),
//                           // SizedBox(height: 10),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.start,
//                           //   crossAxisAlignment: CrossAxisAlignment.center,
//                           //   children: [
//                           //     Stack(
//                           //       clipBehavior: Clip.none,
//                           //       children: [
//                           //         CircleAvatar(
//                           //           radius: 20,
//                           //           backgroundImage: AssetImage("assets/images/profile.png"),
//                           //         ),
//                           //         Positioned(
//                           //           bottom: -02,
//                           //           right: -02,
//                           //           child: CircleAvatar(
//                           //             radius: 08,
//                           //             backgroundColor: Colors.white, // Color(0xFFffb800),
//                           //             child: CircleAvatar(
//                           //               radius: 03,
//                           //               backgroundColor: Color(0xFF2ECC24),
//                           //             ),
//                           //           ),
//                           //         ),
//                           //       ],
//                           //     ),
//                           //     SizedBox(width: 20),
//                           //     Container(
//                           //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                           //       child: Container(
//                           //         width: Get.width / 2,
//                           //         child: Text(
//                           //           "Hi there, How are you?",
//                           //           textAlign: TextAlign.left,
//                           //           style: TextStyle(
//                           //             color: Colors.white,
//                           //             fontSize: 13,
//                           //             fontWeight: FontWeight.bold,
//                           //           ),
//                           //           maxLines: 1000,
//                           //         ),
//                           //       ),
//                           //       decoration: BoxDecoration(
//                           //         color: Color(0xFF27B2CC),
//                           //         borderRadius: BorderRadius.only(
//                           //           topLeft: Radius.circular(10),
//                           //           topRight: Radius.circular(10),
//                           //           bottomRight: Radius.circular(10),
//                           //         ),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(height: 10),
//                           // Text(
//                           //   "09:34 PM",
//                           //   style: TextStyle(color: Color(0xFFC0B4CC)),
//                           // ),
//                           const SizedBox(height: 10),
//                           SizedBox(
//                             height: Get.height / 1.3,
//                             child: ListView.builder(
//                                 physics: const BouncingScrollPhysics(),
//                                 controller: controller.scrollController,
//                                 itemCount: controller.msgData.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       if(controller.msgData[index]['type'] == "text")
//                                         Container(
//                                           margin: const EdgeInsets.only(bottom: 10),
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 10, horizontal: 20),
//                                           decoration: const BoxDecoration(
//                                             color: Color(0xFFFE456A),
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(10),
//                                               topRight: Radius.circular(10),
//                                               bottomLeft: Radius.circular(10),
//                                             ),
//                                           ),
//                                           child: SizedBox(
//                                               width: Get.width / 1.6,
//                                               child: Text(
//                                                 "${controller.msgData[index]['text']}",
//                                                 textAlign: TextAlign.left,
//                                                 style: const TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 13,
//                                                     fontWeight:
//                                                     FontWeight.bold),
//                                                 maxLines: 1000,
//                                               )
//                                             // : Row(
//                                             //   children: [
//                                             //     GestureDetector(
//                                             //       onTap: onPlay,
//                                             //       child: Icon(
//                                             //           isPlay
//                                             //               ? Icons.pause
//                                             //               : Icons
//                                             //                   .play_arrow,
//                                             //           color:
//                                             //               Colors.white),
//                                             //     ),
//                                             //     // FittedBox(
//                                             //     //   child: Container(
//                                             //     //     width: Get.width * 0.56,
//                                             //     //     height: 3,
//                                             //     //     color: Colors.grey,
//                                             //     //   ),
//                                             //     // ),
//                                             //   ],
//                                             // ),
//                                           ),
//                                         )
//                                       else if(controller.msgData[index]['type'] == "audio")
//                                         const Column(
//                                           children: [
//                                             // VoiceMessageBubble(
//                                             //   source: "${cacheDir.path}/$mPath",
//                                             //   isMe: true,
//                                             //   meBgColor: Color(0xFFFE456A),
//                                             //   contactColor: Color(0xFF27B2CC),
//                                             // ),
//                                             SizedBox(height: 10,),
//                                           ],
//                                         )
//                                       else
//                                         Column(
//                                           children: [
//                                             // GestureDetector(
//                                             //   onTap: () {
//                                             //     Navigator.push(
//                                             //       context,
//                                             //       MaterialPageRoute(
//                                             //         builder: (context) => FullScreenImagePage(imageUrl: images[index]),
//                                             //       ),
//                                             //     );
//                                             //   },
//                                             //   child: Hero(
//                                             //     tag: images[index],
//                                             //     child: CachedNetworkImage(
//                                             //       imageUrl: images[index],
//                                             //       fit: BoxFit.cover,
//                                             //       height: 200,
//                                             //       placeholder: (context, url) => CircularProgressIndicator(),
//                                             //       errorWidget: (context, url, error) => Icon(Icons.error),
//                                             //     ),
//                                             //   ),
//                                             // ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) => FullScreenImagePage(imageAsset: controller.msgData[index]['text']),
//                                                   ),
//                                                 );
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: const BorderRadius.only(
//                                                     topLeft: Radius.circular(10),
//                                                     topRight: Radius.circular(10),
//                                                     bottomLeft: Radius.circular(10),
//                                                   ),
//                                                   border: Border.all(
//                                                     color: Colors.grey,
//                                                     width: 2.0,
//                                                   ),
//                                                 ),
//                                                 child: ClipRRect(
//                                                   borderRadius: const BorderRadius.only(
//                                                     topLeft: Radius.circular(10),
//                                                     topRight: Radius.circular(10),
//                                                     bottomLeft: Radius.circular(10),
//                                                   ),
//                                                   child: Hero(
//                                                     tag: controller.msgData[index]['text'],
//                                                     child: Image.file(
//                                                       File(controller.msgData[index]['text']),
//                                                       fit: BoxFit.cover,
//                                                       height: 200,
//                                                       width: Get.width / 2,
//                                                     ),
//
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10,),
//                                           ],
//                                         ),
//                                     ],
//                                   );
//                                 }),
//                           ),
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ))),
//             Expanded(
//               child: SizedBox(
//                 height: Get.height / 13,
//                 // width: Get.width / 1.1,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             // await _picker.pickImage(source: ImageSource.camera);
//                           },
//                           child: const SizedBox(
//                             height: 30,
//                             width: 30,
//                             child: Image(
//                                 image: AssetImage("assets/images/camera.png")),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 05,
//                         ),
//                         GestureDetector(
//                           onTap: () async {
//                             // pickFile(controller);
//                           },
//                           child: const SizedBox(
//                             height: 30,
//                             width: 30,
//                             child: Image(
//                                 image: AssetImage("assets/images/pic.png")),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 05,
//                         ),
//                         // GestureDetector(
//                         //   onTap: onVoiceRecord,
//                         //   child: Container(
//                         //     height: 30,
//                         //     width: 30,
//                         //     child: isRecording
//                         //         ? Icon(Icons.pause, color: Colors.cyan)
//                         //         : Image(
//                         //         image:
//                         //         AssetImage("assets/images/audio.png")),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                     const SizedBox(width: 05),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       height: Get.height / 13,
//                       width: Get.width / 2.5,
//                       color: mainClr,
//                       child: TextField(
//                         controller: controller.msg,
//                         onTap: () {
//                           // setState(() {
//                           //   emojiShowing = false;
//                           // });
//                         },
//                         decoration: const InputDecoration.collapsed(
//                             hintText: 'Type here...', hintStyle: TextStyle()),
//                       ),
//                     ),
//                     const SizedBox(width: 05),
//                     Row(
//                       children: [
//                         // GestureDetector(
//                         //   onTap: () {
//                         //     setState(() {
//                         //       emojiShowing = !emojiShowing;
//                         //       FocusScope.of(context).unfocus();
//                         //     });
//                         //   },
//                         //   child: Container(
//                         //     height: 30,
//                         //     width: 30,
//                         //     child: Image(
//                         //       image: AssetImage("assets/images/emoji.png"),
//                         //       color: emojiShowing ? Colors.blueAccent: null,
//                         //     ),
//                         //   ),
//                         // ),
//                         const SizedBox(
//                           width: 05,
//                         ),
//                         GestureDetector(
//                           // onTap: controller.onSend(),
//                           child: const SizedBox(
//                             height: 30,
//                             width: 30,
//                             child: Image(
//                                 image: AssetImage("assets/images/send.png")),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             // Offstage(
//             //   offstage: !emojiShowing,
//             //   child: SizedBox(
//             //       height: 250,
//             //       child: emojiPicker(
//             //           textEditingController: msg,
//             //           onBackspacePressed: onBackspacePressed)),
//             // ),
//           ],
//         ),
//       );
//     });
//   }
// }
