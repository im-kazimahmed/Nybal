import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nybal/Widgets/dialogs.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/models/conversation_model.dart';
import 'package:nybal/repository/api/auth_api.dart';
import 'package:nybal/utils/validators.dart';
import 'package:nybal/widgets/my_date_util.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/chat_controller.dart';
import '../../../Widgets/bubble.dart';
import '../../../Widgets/full_screen_image.dart';
import '../../../controllers/setting_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/message_model.dart';
import '../../../socket/socket.io.dart';
import '../../controllers/navigation_controller.dart';
import '../../models/call_model.dart';
import '../../models/firebase_user_model.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../../utils/network/cache_helper.dart';

class ChatScreen extends StatefulWidget{
  // final ConversationModel conversation;
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final NavigationController navController = Get.find<NavigationController>();
  final ChatController chatController = Get.find<ChatController>();
  final UserController userController = Get.find<UserController>();
  final SettingController settingController = Get.find<SettingController>();

  // Future<bool> onBackPress(ChatController controller) {
  //   if (isShowSticker) {
  //     setState(() {
  //       isShowSticker = false;
  //     });
  //   } else {
  //     Navigator.pop(context);
  //   }
  //
  //   return Future.value(false);
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Start listening to the text editing controller
      // socket.emit("seenSms", {
      //   "conversation_id": widget.conversation.conversationId,
      //   "toId": widget.conversation.toUserId,
      // });
      chatController.msg.addListener(() {
        final text = chatController.msg.text.trim();
        if (text.isEmpty) {
          socket.emit("stopTyping", {
            "conversationId": chatController.selectedConversation.conversationId
          });
          chatController.textFieldHaveContent.value = false;
        } else {
          if (chatController.textFieldHaveContent.value) return;
          socket.emit("typing", {
            "conversationId": chatController.selectedConversation.conversationId
          });
          chatController.textFieldHaveContent.value = true;
        }
      });
    });

    chatController.getCacheDirectory();
    chatController.mPlayer!.openPlayer().then((value) {
      chatController.isMPlayerInitialized.value = true;
    });

    chatController.openTheRecorder().then((value) {
      chatController.isMPlayerInitialized.value = true;
    });
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if(chatController.selectedConversation.conversationId != null) {
        socket.emit("getMessages", {
          "convo_id": chatController.selectedConversation.conversationId
        });
      }
    });
    super.initState();
  }

  // onSend(ChatController controller) async {
  //   if (isRecording) {
  //     await mRecorder!.stopRecorder().then((value) async {
  //       File voiceFile = File(value!);
  //       Uint8List imageBytes = await voiceFile.readAsBytes();
  //       String base64string = base64.encode(imageBytes);
  //       socket.emit("newSms", {
  //         "toId": widget.conversation.toUserId,
  //         "fromId": widget.conversation.fromUserId,
  //         "text": msg.text,
  //         "media": "data:audio/mp4;base64,$base64string",
  //         "mediaType": "mp4",
  //         "cId": widget.conversation.conversationId
  //       });
  //       isRecording = false;
  //       controller.msgData.add({"text": value, 'type': "audio"});
  //       _scrollToLastItem();
  //     });
  //   } else {
  //     if (!msg.text.isEmpty) {
  //       socket.emit("newSms", {
  //         "toId": widget.conversation.toUserId,
  //         "fromId": widget.conversation.fromUserId,
  //         "text": msg.text,
  //         "cId": widget.conversation.conversationId
  //       });
  //       controller.msgData.add({"text": msg.text, 'type': "text"});
  //       msg.clear();
  //       emojiShowing = false;
  //       FocusScope.of(context).unfocus();
  //       _scrollToLastItem();
  //     } else {
  //       return;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<ChatController>(builder: (ChatController controller) {
          UserDataModel? user = controller.getChatUser();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: themeController.isDarkMode.isTrue ?
                ThemeData.dark().scaffoldBackgroundColor:mainClr,
                appBar: AppBar(
                  elevation: 0,
                  forceMaterialTransparency: true,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarColor: Colors.transparent,
                  ),
                  excludeHeaderSemantics: true,
                  backgroundColor: themeController.isDarkMode.isTrue ?
                  ThemeData.dark().scaffoldBackgroundColor: const Color(0xfffbf5f5),
                  title: GestureDetector(
                    onTap: ()=> controller.clearAll(),
                    child: SizedBox(
                      height: 53,
                      child: Center(
                        child: Card(
                          elevation: 1,
                          margin: const EdgeInsets.only(top: 2),
                          child: Container(
                            height: Get.height / 12,
                            width: Get.width / 1.2,
                            color: themeController.isDarkMode.isTrue ?
                            ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9): Colors.white,
                            child: Row(children: [
                              const SizedBox(width: 05),
                              GestureDetector(
                                onTap: () {
                                  controller.onChatBoxOpenChanged(false);
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0xFFC0B4CC),
                                ),
                              ),
                              const SizedBox(width: 05),
                              const Text(
                                "—",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFC0B4CC),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  // controller.onDialCall(
                                  //   isVideoCall: true,
                                  //   userId: user.id!,
                                  // );
                                },
                                child: const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Image(
                                    image: AssetImage("assets/images/green_call.png"),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  bool result = userController.isPermissionEnabled(permissionName: permissionCalls);
                                  // if (result) {
                                  //   int? limit = userController.getPermissionLimit(permissionCalls, permissionCalls);
                                  //   if(limit != null && limit != 0) {
                                  //     dialVideoCall();
                                  //   } else {
                                  //     dialVideoCall();
                                  //   }
                                  // } else {
                                  //   showShortToast("You don't have the permission to call");
                                  // }
                                },
                                child: const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Image(
                                    image: AssetImage("assets/images/green_vdo.png"),
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: 25,
                              //   width: 25,
                              //   child: Image(image: AssetImage("assets/images/flag.png")),
                              // ),
                              const SizedBox(width: 10),
                              if(controller.isLoading.isFalse)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 20,
                                          width: 30,
                                          child: CachedNetworkImage(
                                            imageUrl: "${chatController.selectedConversation.flag}",
                                            fit: BoxFit.cover,
                                            height: 20,
                                            width: 30,
                                            placeholder: (context, url) {
                                              return const CircleAvatar(
                                                child: Icon(
                                                  CupertinoIcons.person,
                                                ),
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return const CircleAvatar(
                                                child: Icon(CupertinoIcons.person),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          chatController.selectedConversation.firstName.toString(),
                                          style: TextStyle(
                                            // fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "myFontLight",
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.white:const Color(0xFF574667),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                const CustomLoader(),
                              const SizedBox(width: 15),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print(controller.selectedConversation.toJson());
                                      // if(navController)
                                      // if(navController.selectedNavIndex == 0) {
                                      //   int? fromUserId = controller.selectedConversation.fromUserId;
                                      //   int? toUserId = controller.selectedConversation.toUserId;
                                      //   if(fromUserId != null && controller.isAuthenticatedUser(fromUserId)) {
                                      //     userController.selectedUser.value = userController.getUserData(fromUserId)!;
                                      //   } else {
                                      //     userController.selectedUser.value = userController.getUserData(toUserId)!;
                                      //   }
                                      //   // userController.addProfileVisitRecord(controller.selectedConversation.toUserId!);
                                      //   navController.previousIndex.value = navController.selectedNavIndex;
                                      //   navController.handleNavIndexChanged(10);
                                      // } else {
                                      //   userController.addProfileVisitRecord(userController.selectedUser.value.id!);
                                      //   navController.previousIndex.value = navController.selectedNavIndex;
                                      //   navController.handleNavIndexChanged(10);
                                      // }
                                      print(navController.selectedNavIndex);
                                    },
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: controller.selectedConversation.profilePic.toString(),
                                        fit: BoxFit.cover,
                                        height: 30,
                                        width: 30,
                                        placeholder: (context, url) => const CircleAvatar(
                                          child: Icon(CupertinoIcons.person),
                                        ),
                                        errorWidget: (context, url, error) =>
                                        const CircleAvatar(
                                          child: Icon(CupertinoIcons.person),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if(controller.selectedConversation.toUserId!= null && controller.isUserOnline(controller.selectedConversation.toUserId!))
                                    const Positioned(
                                      bottom: -02,
                                      right: -02,
                                      child: CircleAvatar(
                                        radius: 08,
                                        backgroundColor: Colors.white, // Color(0xFFffb800),
                                        child: CircleAvatar(
                                          radius: 03,
                                          backgroundColor: Color(0xFF2ECC24),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              IconButton(
                                onPressed: () => controller.onUserBlockMenuChanged(),
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Color(0xFFC0B4CC),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                body: GestureDetector(
                  onTap: ()=> controller.clearAll(),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 9,
                            child: SizedBox(
                              // height: Get.height / 1.4,
                              width: Get.width / 1.2,
                              // color: Colors.red,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Container(
                                    //   width: Get.width / 1.1,
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.center,
                                    //     crossAxisAlignment: CrossAxisAlignment.center,
                                    //     children: [
                                    //       Container(
                                    //         height: 1,
                                    //         width: Get.width / 4,
                                    //         color: Color(0xFFC0B4CC),
                                    //       ),
                                    //       SizedBox(width: 10),
                                    //       Text(
                                    //         "Today",
                                    //         style: TextStyle(color: Color(0xFFC0B4CC)),
                                    //       ),
                                    //       SizedBox(width: 10),
                                    //       Container(
                                    //         height: 1,
                                    //         width: Get.width / 4,
                                    //         color: Color(0xFFC0B4CC),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // SizedBox(height: 20),
                                    // Text(
                                    //   "09:34 PM",
                                    //   style: TextStyle(color: Color(0xFFC0B4CC)),
                                    // ),
                                    // SizedBox(height: 10),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //     Stack(
                                    //       clipBehavior: Clip.none,
                                    //       children: [
                                    //         CircleAvatar(
                                    //           radius: 20,
                                    //           backgroundImage: AssetImage("assets/images/profile.png"),
                                    //         ),
                                    //         Positioned(
                                    //           bottom: -02,
                                    //           right: -02,
                                    //           child: CircleAvatar(
                                    //             radius: 08,
                                    //             backgroundColor: Colors.white, // Color(0xFFffb800),
                                    //             child: CircleAvatar(
                                    //               radius: 03,
                                    //               backgroundColor: Color(0xFF2ECC24),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     SizedBox(width: 20),
                                    //     Container(
                                    //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    //       child: Container(
                                    //         width: Get.width / 2,
                                    //         child: Text(
                                    //           "Hi there, How are you?",
                                    //           textAlign: TextAlign.left,
                                    //           style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 13,
                                    //             fontWeight: FontWeight.bold,
                                    //           ),
                                    //           maxLines: 1000,
                                    //         ),
                                    //       ),
                                    //       decoration: BoxDecoration(
                                    //         color: Color(0xFF27B2CC),
                                    //         borderRadius: BorderRadius.only(
                                    //           topLeft: Radius.circular(10),
                                    //           topRight: Radius.circular(10),
                                    //           bottomRight: Radius.circular(10),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 10),
                                    // Text(
                                    //   "09:34 PM",
                                    //   style: TextStyle(color: Color(0xFFC0B4CC)),
                                    // ),
                                    const SizedBox(height: 10),
                                    if(controller.selectedConversation.messages != null && controller.isLoading.isFalse)
                                      Container(
                                        height: Get.height / 1.3,
                                        padding: const EdgeInsets.only(right: foundation.kIsWeb ? 20: 0),
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          controller: controller.scrollController,
                                          itemCount: controller.selectedConversation.messages?.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            ConversationModel conversation = controller.selectedConversation;
                                            if(conversation.messages![index].mediaType == "" && conversation.messages![index].media == "") {
                                              if(conversation.messages![index].messageText.isNotEmpty) {
                                                return textMessageTile(conversation.messages![index]);
                                              }
                                              return Container();
                                            } else if(controller.selectedConversation.messages![index].mediaType == "mp4") {
                                              return voiceMessageTile(conversation.messages![index]);
                                            } else {
                                              return imageMessageTile(conversation.messages![index]);
                                            }
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                if(conversation.messages![index].mediaType == "" && conversation.messages![index].media == "")
                                                  ...[
                                                    if(conversation.messages![index].messageText.isNotEmpty)
                                                      Column(
                                                        children: [
                                                          if(controller.isMsgSentByMe(fromId: conversation.messages?[index].fromId))
                                                            Container(
                                                              alignment: Alignment.centerRight,
                                                              margin: const EdgeInsets.only(bottom: 10),
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 10, horizontal: 20,
                                                              ),
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xFFFE456A),
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(10),
                                                                  topRight: Radius.circular(10),
                                                                  bottomLeft: Radius.circular(10),
                                                                ),
                                                              ),
                                                              child: SizedBox(
                                                                width: foundation.kIsWeb ? 15.w : Get.width / 1.6,
                                                                child: Text(
                                                                  "${controller.selectedConversation.messages?[index].messageText}",
                                                                  textAlign: TextAlign.right,
                                                                  style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  overflow: TextOverflow.clip,
                                                                  maxLines: 1000,
                                                                ),
                                                                // : Row(
                                                                //   children: [
                                                                //     GestureDetector(
                                                                //       onTap: onPlay,
                                                                //       child: Icon(
                                                                //           isPlay
                                                                //               ? Icons.pause
                                                                //               : Icons
                                                                //                   .play_arrow,
                                                                //           color:
                                                                //               Colors.white),
                                                                //     ),
                                                                //     // FittedBox(
                                                                //     //   child: Container(
                                                                //     //     width: Get.width * 0.56,
                                                                //     //     height: 3,
                                                                //     //     color: Colors.grey,
                                                                //     //   ),
                                                                //     // ),
                                                                //   ],
                                                                // ),
                                                              ),
                                                            )
                                                          else
                                                            Container(
                                                              alignment: Alignment.centerLeft,
                                                              margin: const EdgeInsets.only(bottom: 10),
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 10, horizontal: 20,
                                                              ),
                                                              decoration: const BoxDecoration(
                                                                color: AppColors.blueColor,
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(10),
                                                                  topRight: Radius.circular(10),
                                                                  bottomLeft: Radius.circular(10),
                                                                ),
                                                              ),
                                                              child: SizedBox(
                                                                width: foundation.kIsWeb ? 15.w : Get.width / 1.6,
                                                                child: Text(
                                                                  "${controller.selectedConversation.messages?[index].messageText}",
                                                                  textAlign: TextAlign.left,
                                                                  style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  overflow: TextOverflow.clip,
                                                                  maxLines: 1000,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                  ]
                                                else if(controller.selectedConversation.messages![index].mediaType == "mp4")
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: foundation.kIsWeb ? 15.w : null,
                                                        child: FittedBox(
                                                          child: VoiceMessageBubble(
                                                            source: "${controller.selectedConversation.messages?[index].media}",
                                                            isMe: true,
                                                            meBgColor: const Color(0xFFFE456A),
                                                            contactColor: const Color(0xFF27B2CC),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10),
                                                    ],
                                                  )
                                                else
                                                  Column(
                                                    children: [
                                                      // GestureDetector(
                                                      //   onTap: () {
                                                      //     Navigator.push(
                                                      //       context,
                                                      //       MaterialPageRoute(
                                                      //         builder: (context) => FullScreenImagePage(imageUrl: images[index]),
                                                      //       ),
                                                      //     );
                                                      //   },
                                                      //   child: Hero(
                                                      //     tag: images[index],
                                                      //     child: CachedNetworkImage(
                                                      //       imageUrl: images[index],
                                                      //       fit: BoxFit.cover,
                                                      //       height: 200,
                                                      //       placeholder: (context, url) => CircularProgressIndicator(),
                                                      //       errorWidget: (context, url, error) => Icon(Icons.error),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => FullScreenImagePage(imageAsset: controller.selectedConversation.messages![index].messageText),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              topRight: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10),
                                                            ),
                                                            border: Border.all(
                                                              color: Colors.grey,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: const BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              topRight: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10),
                                                            ),
                                                            child: Hero(
                                                              tag: controller.selectedConversation.messages![index].messageText,
                                                              child: Image.network(controller.selectedConversation.messages![index].messageText,
                                                                fit: BoxFit.cover,
                                                                height: 200,
                                                                width: Get.width / 2,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                    ],
                                                  ),
                                              ],
                                            );
                                        }),
                                      )
                                    else
                                      const Center(child: CustomLoader()),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height / 13,
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => controller.selectImage(
                                        context: context,
                                        source: ImageSource.camera,
                                      ),
                                      child: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image(
                                          image: AssetImage("assets/images/camera.png"),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 05,
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.selectImage(
                                        context: context,
                                        source: ImageSource.gallery,
                                      ),
                                      child: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image(
                                          image: AssetImage("assets/images/pic.png"),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 05,
                                    ),
                                    GestureDetector(
                                      onTap: controller.onVoiceRecord,
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: controller.isRecording.isTrue ?
                                        const Icon(Icons.pause, color: Colors.cyan):
                                        const Image(image:AssetImage("assets/images/audio.png")),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 05),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: Get.height / 13,
                                    width: Get.width / 2.5,
                                    color: themeController.isDarkMode.isTrue ?
                                    ThemeData.dark().scaffoldBackgroundColor: mainClr,
                                    child: TextField(
                                      controller: controller.msg,
                                      onTap: () => controller.onMessageFieldTap(),
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Type here...', hintStyle: TextStyle(
                                        color: themeController.isDarkMode.isTrue ?
                                        Colors.white: null,
                                      ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 05),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => controller.onEmojiShowChanged(context),
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image(
                                          image: const AssetImage("assets/images/emoji.png"),
                                          color: controller.emojiShowing.value ? Colors.blueAccent: null,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 05,
                                    ),
                                    GestureDetector(
                                      // onTap: () {
                                      //   if (controller.msg.text.isNotEmpty) {
                                      //     PackagePermissions? permissionData = userController.userData.packagePermissions?.firstWhere(
                                      //           (perm) => perm.permissionName == permissionUnlimitedReplies,
                                      //     );
                                      //
                                      //     if (permissionData?.permissionAllow != true) {
                                      //       // Show the message that the user doesn't have permission
                                      //       showShortToast("You don't have permission to send a message");
                                      //       return;
                                      //     }
                                      //
                                      //     int? permissionLimit = permissionData?.permissionLimit;
                                      //     if (permissionLimit != null) {
                                      //       SubPermissions? subPermissions = permissionData?.subPermissions;
                                      //       if (subPermissions != null) {
                                      //         PerGender? perGender = subPermissions.perGender;
                                      //         bool isMaleEnabled = perGender?.male == true;
                                      //
                                      //         dynamic female = perGender?.female is bool ? perGender?.female: perGender?.female['limit'];
                                      //
                                      //         if (isMaleEnabled == false && userController.selectedUser.value.gender == "Male") {
                                      //           showShortToast("You don't have permission to send a message to this gender");
                                      //           return;
                                      //         }
                                      //
                                      //         if (userController.selectedUser.value.gender == "Female") {
                                      //           if (female != null && female is int) {
                                      //             int femaleLimit = female;
                                      //             if (femaleLimit < permissionLimit) {
                                      //               controller.onSend(chatController.selectedConversation, context);
                                      //               return;
                                      //             }
                                      //           } else {
                                      //             controller.onSend(chatController.selectedConversation, context);
                                      //             return;
                                      //           }
                                      //         }
                                      //       } else {
                                      //         return;
                                      //       }
                                      //     }
                                      //
                                      //     int? sentLimit = userController.getPermissionLimit(permissionUnlimitedReplies, "replies");
                                      //     if (sentLimit != null && sentLimit < permissionLimit!) {
                                      //       controller.onSend(chatController.selectedConversation, context);
                                      //     }
                                      //   }
                                      // },
                                      onTap: ()=> controller.onSend(chatController.selectedConversation, context),
                                      child: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image(
                                          image: AssetImage("assets/images/send.png"),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Offstage(
                            offstage: !controller.emojiShowing.value,
                            child: SizedBox(
                              height: 250,
                              child: emojiPicker(
                                textEditingController: controller.msg,
                                onBackspacePressed: controller.onBackspacePressed,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (controller.isBlockMenuOpened.isTrue)
                        Positioned(
                          top: 0,
                          right: 30,
                          child: Card(
                            elevation: 7.0,
                            shadowColor: const Color.fromARGB(255, 224, 224, 224),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    int? fromId = controller.selectedConversation.fromUserId;
                                    int? toUserId = controller.selectedConversation.toUserId;

                                    if(fromId != null && !controller.isAuthenticatedUser(fromId)) {
                                      final index = userController.usersList.indexWhere((element) => element.id == fromId);
                                      UserDataModel user = userController.usersList[index];
                                      if(user.hasBlocked == true) {
                                        userController.unblockBlockedUser(
                                          recordId: index,
                                          userId: fromId,
                                        ).then((value) => controller.onUserBlockMenuChanged());
                                      } else {
                                        userController.blockUser(
                                          recordId: index,
                                          userId: fromId,
                                        ).then((value) => controller.onUserBlockMenuChanged());
                                      }
                                    } else {
                                      final index = userController.usersList.indexWhere((element) => element.id == toUserId);
                                      UserDataModel user = userController.usersList[index];
                                      if(user.hasBlocked == true) {
                                        userController.unblockBlockedUser(
                                          recordId: index,
                                          userId: toUserId!,
                                        ).then((value) => controller.onUserBlockMenuChanged());
                                      } else {
                                        userController.blockUser(
                                          recordId: index,
                                          userId: toUserId!,
                                        ).then((value) => controller.onUserBlockMenuChanged());
                                      }
                                    }
                                  },
                                  child: Container(
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                    // ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      user?.hasBlocked == true ? "Unblock": "Block",
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if(user != null) {
                                      userController.reportUser(
                                        user.id!,
                                      ).then((value) => controller.onUserBlockMenuChanged());
                                    }
                                  },
                                  child: Container(
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                    // ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      "Report",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget textMessageTile(MessageModel message) {
    if(chatController.isMsgSentByMe(fromId: message.fromId)) {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 10, left: 30),
            padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFFE456A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: SizedBox(
              width: foundation.kIsWeb ? 15.w : Get.width / 1.6,
              child: Text(
                message.messageText,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1000,
              ),
              // : Row(
              //   children: [
              //     GestureDetector(
              //       onTap: onPlay,
              //       child: Icon(
              //           isPlay
              //               ? Icons.pause
              //               : Icons
              //                   .play_arrow,
              //           color:
              //               Colors.white),
              //     ),
              //     // FittedBox(
              //     //   child: Container(
              //     //     width: Get.width * 0.56,
              //     //     height: 3,
              //     //     color: Colors.grey,
              //     //   ),
              //     // ),
              //   ],
              // ),
            ),
          ),
          if(message.msgTime != null && message.msgTime != "")
            Column(
              children: [
                Text(
                  MyDateUtil.formatDateTime(message.msgTime.toString()),
                  style: const TextStyle(
                    color: Color(0xffC0B4CC),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  height: 35,
                  imageUrl: chatController.selectedConversation.profilePic.toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                  errorWidget: (context, url, error) =>
                  const CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 30),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    width: foundation.kIsWeb ? 15.w : Get.width / 1.6,
                    child: Text(
                      message.messageText,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1000,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if(message.msgTime != null && message.msgTime != "")
            Column(
              children: [
                Text(
                  MyDateUtil.formatDateTime(message.msgTime.toString()),
                  style: const TextStyle(
                    color: Color(0xffC0B4CC),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
        ],
      );
    }
  }

  Widget imageMessageTile(MessageModel message) {
    bool isSentByMe = chatController.isMsgSentByMe(fromId: message.fromId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!isSentByMe)
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      height: 35,
                      imageUrl: chatController.selectedConversation.profilePic.toString(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                      errorWidget: (context, url, error) =>
                      const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImagePage(imageAsset: message.media!),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    margin: EdgeInsets.only(
                      left: isSentByMe ? 40: 0,
                      // right: !isSentByMe ? 10: 0,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Hero(
                        tag: message.media!,
                        child: Image.network(message.media!,
                          fit: BoxFit.cover,
                          height: 200,
                          width: Get.width / 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if(message.msgTime != null && message.msgTime != "")
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  MyDateUtil.formatDateTime(message.msgTime.toString()),
                  style: const TextStyle(
                    color: Color(0xffC0B4CC),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
        ],
      ),
    );
  }

  Widget voiceMessageTile(MessageModel message) {
    bool isSentByMe = chatController.isMsgSentByMe(fromId: message.fromId);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(!isSentByMe)
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 35,
                    imageUrl: chatController.selectedConversation.profilePic.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                    errorWidget: (context, url, error) =>
                    const CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Container(
                width: foundation.kIsWeb ? 15.w: Get.width,
                // width: foundation.kIsWeb ? 15.w : null,
                margin: EdgeInsets.only(
                  left: isSentByMe ? 40: 0,
                  // right: !isSentByMe ? 10: 0,
                ),
                child: FittedBox(
                  child: VoiceMessageBubble(
                    source: message.media!,
                    isMe: isSentByMe ? true: false,
                    meBgColor: const Color(0xFFFE456A),
                    contactColor: const Color(0xFF27B2CC),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // void dialVideoCall() {
  //   AuthApi().getUserDataByAppId(appUserId: 292).then((user) {
  //     print(CacheHelper.getString(key: 'uId'));
  //     String uid = user.id;
  //     FirebaseUserModel currentUser = FirebaseUserModel.fromJsonMap(map: user.data()!, uId: uid);
  //     HomeCubit.get(context).fireVideoCall(
  //       callModel: CallModel(
  //         id: 'call_${UniqueKey().hashCode.toString()}',
  //         callerId: CacheHelper.getString(key: 'uId'),
  //         callerAvatar: "",
  //         callerName: "test",
  //         receiverId: uid,
  //         receiverAvatar: currentUser.avatar,
  //         receiverName: currentUser.name,
  //         status: CallStatus.ringing.name,
  //         createAt: DateTime.now().millisecondsSinceEpoch,
  //         current: true,
  //       ),
  //     );
  //   });
  //
  //   // controller.onDialCall(
  //   //   isVideoCall: true,
  //   //   userId: userController.selectedUser.value.id!,
  //   // );
  //   // Get.to(()=> const videoCall());
  // }
}

Widget emojiPicker(
    {required TextEditingController textEditingController,
    required VoidCallback onBackspacePressed}) {
  return EmojiPicker(
    // onEmojiSelected: (Category category, Emoji emoji) {
    //     // Do something when emoji is tapped (optional)
    // },
    onBackspacePressed: onBackspacePressed,
    textEditingController: textEditingController,
    config: Config(
      columns: 7,
      emojiSizeMax: 32 *
          (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
      verticalSpacing: 0,
      horizontalSpacing: 0,
      gridPadding: EdgeInsets.zero,
      initCategory: Category.RECENT,
      bgColor: const Color(0xFFF2F2F2),
      indicatorColor: Colors.blue,
      iconColor: Colors.grey,
      iconColorSelected: Colors.blue,
      backspaceColor: Colors.blue,
      skinToneDialogBgColor: Colors.white,
      skinToneIndicatorColor: Colors.grey,
      enableSkinTones: true,
      recentTabBehavior: RecentTabBehavior.RECENT,
      recentsLimit: 28,
      noRecents: const Text('No Recents',
          style: TextStyle(fontSize: 20, color: Colors.black26),
          textAlign: TextAlign.center),
      loadingIndicator: const SizedBox.shrink(),
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL,
    ),
  );

}
