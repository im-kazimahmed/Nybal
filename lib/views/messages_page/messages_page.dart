import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/custom_checkbox.dart';
import 'package:nybal/Widgets/images.dart';
import 'package:nybal/Widgets/responsive_widget.dart';
import 'package:nybal/controllers/chat_controller.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/models/conversation_model.dart';
import '../../../Widgets/theme_data.dart';
import '../../../controllers/user_controller.dart';
import '../../../widgets/my_date_util.dart';
import '../../../widgets/top_bar.dart';
import '../../controllers/navigation_controller.dart';
import '../Send_Message/send_message.dart';
import '../web_views/sideBarMenus.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({super.key});
  final UserController userController = Get.find<UserController>();
  final NavigationController navController = Get.find<NavigationController>();
  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<ChatController>(builder: (ChatController controller) {
          return WillPopScope(
            onWillPop: () async {
              navController.previousIndex.value = navController.selectedNavIndex;
              navController.handleNavIndexChanged(navController.previousIndex.value);
              return false;
            },
            child: SafeArea(
              child: Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  if (ResponsiveWidget.isSmallScreen(context))
                    FutureBuilder<List<ConversationModel>?>(
                      future: userController.getAllUserConversations(),
                      builder: (context, snapshot) {
                        return Stack(
                          children: [
                            Container(
                              height: Get.height,
                              width: Get.width,
                              color: themeController.isDarkMode.isTrue ?
                              ThemeData.dark().scaffoldBackgroundColor:mainClr,
                              child: Column(
                                children: [
                                  const SizedBox(height: 40),
                                  Text(
                                    "Messages",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "myFontLight",
                                      color: themeController.isDarkMode.isTrue ?
                                      Colors.white:const Color(0xFF574667),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: Container(
                                      height: Get.height,
                                      width: Get.width,
                                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 200),
                                      // color: Colors.red,
                                      child: userController.userConversations.isNotEmpty ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: userController.userConversations.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          ConversationModel conversation = userController.userConversations[index];
                                          return GestureDetector(
                                            onLongPress: () => controller.onConversationLongPress(index, conversation.conversationId),
                                            onTap: () {
                                              controller.selectedConversation = conversation;
                                              if(!ResponsiveWidget.isSmallScreen(context)) {
                                                controller.onChatBoxOpenChanged(true);
                                              } else {
                                                Get.to(()=> const ChatScreen());
                                              }
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15),
                                                side: BorderSide(
                                                  color: (controller.selectedConversations.contains(index))
                                                      ? Colors.blue.withOpacity(0.5)
                                                      : Colors.transparent,
                                                )
                                              ),
                                              // margin: const EdgeInsets.all(05),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          if(controller.selectedConversations.isNotEmpty)
                                                            Checkbox(
                                                              value: controller.selectedConversations.contains(index),
                                                              onChanged: (value) => controller.onConversationSelect(
                                                                index,
                                                                conversation.conversationId,
                                                                value,
                                                              ),
                                                            )
                                                          else
                                                            Stack(
                                                              clipBehavior: Clip.none,
                                                              children: [
                                                                ClipOval(
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: conversation.profilePic.toString(),
                                                                    fit: BoxFit.cover,
                                                                    height: 60,
                                                                    width: 60,
                                                                    placeholder: (context, url) => const CircleAvatar(
                                                                      child: Icon(CupertinoIcons.person),
                                                                    ),
                                                                    errorWidget: (context, url, error) =>
                                                                    const CircleAvatar(
                                                                      child: Icon(CupertinoIcons.person),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if(controller.isUserOnline(conversation.toUserId!))
                                                                  const Positioned(
                                                                    bottom: -02,
                                                                    right: -02,
                                                                    child: CircleAvatar(
                                                                      radius: 10,
                                                                      backgroundColor: Colors.white, // Color(0xFFffb800),
                                                                      child: CircleAvatar(
                                                                        radius: 05,
                                                                        backgroundColor: Color(0xFF2ECC24),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          const SizedBox(width: 10),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "${conversation.firstName}",
                                                                  style: const TextStyle(
                                                                    fontSize: 13,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontFamily: "myFontLight",
                                                                    color: Color(0xFF574667),
                                                                  ),
                                                                ),
                                                                if(conversation.mediaType != null && conversation.mediaType == "jpg")
                                                                  const Row(
                                                                    children: [
                                                                      Text(
                                                                        "Image",
                                                                        style: TextStyle(
                                                                          fontSize: 10,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          fontWeight: FontWeight.w200,
                                                                          fontFamily: "myFontLight",
                                                                          color: Color(0xFF574667),
                                                                        ),
                                                                      ),
                                                                      Icon(
                                                                        Icons.image,
                                                                        size: 12,
                                                                      ),
                                                                    ],
                                                                  )
                                                                else
                                                                  Text(
                                                                    "${conversation.lastMessage}",
                                                                    style: const TextStyle(
                                                                      fontSize: 10,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontWeight: FontWeight.w200,
                                                                      fontFamily: "myFontLight",
                                                                      color: Color(0xFF574667),
                                                                    ),
                                                                  ),
                                                                if(controller.selectedConversations.contains(index))
                                                                  FittedBox(
                                                                    child: Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap: () => controller.onConversationDelete(
                                                                            index,
                                                                            conversation.conversationId,
                                                                          ),
                                                                          child: SizedBox(
                                                                            height: 15,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Image.asset(
                                                                                  Images.delete,
                                                                                  color: AppColors.pinkButton,
                                                                                ),
                                                                                const SizedBox(width: 5),
                                                                                const Text(
                                                                                  "Eliminate",
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: AppColors.pinkButton,
                                                                                    decoration: TextDecoration.underline,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height: 15,
                                                                          child: CustomCheckBox(
                                                                            checkBoxValue: conversation.unreadMessagesCount == 0,
                                                                            onChangedFunction: (value){
                                                                              if(conversation.unreadMessagesCount > 0) {
                                                                                controller.markAsReadConversation(
                                                                                  conversation.conversationId,
                                                                                );
                                                                              }
                                                                            },
                                                                            activeColor: conversation.unreadMessagesCount == 0 ?
                                                                                Colors.grey:AppColors.pinkButton,
                                                                            borderColor: AppColors.pinkButton,
                                                                            flipPosition: false,
                                                                            alignment: MainAxisAlignment.center,
                                                                            text: "Mark as read",
                                                                            textColor: AppColors.pinkButton,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        if(conversation.latestMessageDate != null && conversation.latestMessageDate != "")
                                                          SizedBox(
                                                            width: 110,
                                                            child: Text(
                                                              MyDateUtil.formatDateTime(conversation.latestMessageDate!),
                                                              style: const TextStyle(
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w200,
                                                                overflow: TextOverflow.ellipsis,
                                                                fontFamily: "myFontLight",
                                                                color: Color(0xFFC0B4CC),
                                                              ),
                                                              overflow: TextOverflow.clip,
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          )
                                                        else
                                                          Text(
                                                            conversation.createdAt != "" ?
                                                            MyDateUtil.formatDateTime(conversation.createdAt!): "",
                                                            style: const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w200,
                                                              overflow: TextOverflow.ellipsis,
                                                              fontFamily: "myFontLight",
                                                              color: Color(0xFFC0B4CC),
                                                            ),
                                                          ),
                                                        const SizedBox(height: 10),
                                                        if(conversation.unreadMessagesCount > 0 && !controller.selectedConversations.contains(index))
                                                          Container(
                                                            alignment: Alignment.center,
                                                            height: 20,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius: BorderRadius.circular(30),
                                                            ),
                                                            child: Text(
                                                              "+${conversation.unreadMessagesCount}",
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w200,
                                                                fontFamily: "myFontLight",
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ): Center(
                                        child: Text(
                                          "No conversations found",
                                          style: TextStyle(
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.white: null
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if(controller.selectedConversations.length > 1)
                              Positioned(
                                bottom: 210,
                                right: 10,
                                left: 80,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => controller.onSelectedConversationsDelete(),
                                          child: SizedBox(
                                            height: 15,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  Images.delete,
                                                  color: AppColors.whiteColor,
                                                ),
                                                const SizedBox(width: 5),
                                                const Text(
                                                  "Eliminate",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.whiteColor,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                        child: CustomCheckBox(
                                          checkBoxValue: false,
                                          onChangedFunction: (value){
                                            controller.markSelectedConversationsAsSeen();
                                          },
                                          activeColor: AppColors.whiteColor,
                                          borderColor: AppColors.whiteColor,
                                          flipPosition: false,
                                          alignment: MainAxisAlignment.center,
                                          text: "Mark as read",
                                          textColor: AppColors.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      }
                  ) else Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: FutureBuilder<List<ConversationModel>?>(
                                future: userController.getAllUserConversations(),
                                builder: (context, snapshot) {
                                  return Container(
                                    height: Get.height,
                                    width: Get.width,
                                    color: mainClr,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 40),
                                        const Text(
                                          "Messages",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "myFontLight",
                                            color: Color(0xFF574667),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: Get.height / 1.2,
                                          width: Get.width / 1.1,
                                          // color: Colors.red,
                                          child: userController.userConversations.isNotEmpty ? ListView.builder(
                                            itemCount: userController.userConversations.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              ConversationModel conversation = userController.userConversations[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.selectedConversation = conversation;
                                                  if(!ResponsiveWidget.isSmallScreen(context)) {
                                                    controller.onChatBoxOpenChanged(true);
                                                  } else {
                                                    Get.to(()=> const ChatScreen());
                                                  }
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  margin: const EdgeInsets.all(05),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                    height: Get.height / 08,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Stack(
                                                              clipBehavior: Clip.none,
                                                              children: [
                                                                ClipOval(
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: conversation.profilePic.toString(),
                                                                    fit: BoxFit.cover,
                                                                    height: 60,
                                                                    width: 60,
                                                                    placeholder: (context, url) => const CircleAvatar(
                                                                      child: Icon(CupertinoIcons.person),
                                                                    ),
                                                                    errorWidget: (context, url, error) =>
                                                                    const CircleAvatar(
                                                                      child: Icon(CupertinoIcons.person),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if(controller.isUserOnline(conversation.toUserId!))
                                                                  const Positioned(
                                                                    bottom: -02,
                                                                    right: -02,
                                                                    child: CircleAvatar(
                                                                      radius: 10,
                                                                      backgroundColor: Colors.white, // Color(0xFFffb800),
                                                                      child: CircleAvatar(
                                                                        radius: 05,
                                                                        backgroundColor: Color(0xFF2ECC24),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                            const SizedBox(width: 10),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "${conversation.firstName}",
                                                                  style: const TextStyle(
                                                                    fontSize: 13,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontFamily: "myFontLight",
                                                                    color: Color(0xFF574667),
                                                                  ),
                                                                ),
                                                                if(conversation.mediaType != null)
                                                                  const Row(
                                                                    children: [
                                                                      Text(
                                                                        "Image",
                                                                        style: TextStyle(
                                                                          fontSize: 10,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          fontWeight: FontWeight.w200,
                                                                          fontFamily: "myFontLight",
                                                                          color: Color(0xFF574667),
                                                                        ),
                                                                      ),
                                                                      Icon(
                                                                        Icons.image,
                                                                      ),
                                                                    ],
                                                                  )
                                                                else
                                                                  Text(
                                                                    "${conversation.lastMessage}",
                                                                    style: const TextStyle(
                                                                      fontSize: 10,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontWeight: FontWeight.w200,
                                                                      fontFamily: "myFontLight",
                                                                      color: Color(0xFF574667),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            if(conversation.latestMessageDate != null && conversation.latestMessageDate != "")
                                                              Text(
                                                                MyDateUtil.formatDateTime(conversation.latestMessageDate!),
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight.w200,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontFamily: "myFontLight",
                                                                  color: Color(0xFFC0B4CC),
                                                                ),
                                                              )
                                                            else
                                                              Text(
                                                                conversation.createdAt != "" ?
                                                                MyDateUtil.formatDateTime(conversation.createdAt!): "",
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight.w200,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontFamily: "myFontLight",
                                                                  color: Color(0xFFC0B4CC),
                                                                ),
                                                              ),
                                                            const SizedBox(height: 10),
                                                            if(conversation.unreadMessagesCount > 0)
                                                              Container(
                                                                alignment: Alignment.center,
                                                                height: 20,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(30),
                                                                ),
                                                                child: Text(
                                                                  "+${conversation.unreadMessagesCount}",
                                                                  textAlign: TextAlign.center,
                                                                  style: const TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight.w200,
                                                                    fontFamily: "myFontLight",
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ): const Center(child: Text("No conversations found")),
                                        )
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                          const SizedBox(width: 20),
                          SideBarMenus(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
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

