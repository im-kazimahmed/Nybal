import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/models/ticket_model.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/dialogs.dart';
import '../../controllers/support_controller.dart';
import '../../widgets/theme_data.dart';
import '../Send_Message/send_message.dart';

class TicketDetails extends StatefulWidget {
  final TicketModel ticket;
  const TicketDetails({Key? key, required this.ticket}) : super(key: key);

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  final controller = Get.find<SupportSystemController>();

  @override
  void initState() {
    super.initState();
    controller.getTicketAnswers(ticketId: widget.ticket.ticketId!);
  }

  @override
  Widget build(BuildContext context) {
    TicketModel ticket = widget.ticket;
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<SupportSystemController>(builder: (SupportSystemController controller) {
          return Scaffold(
              backgroundColor: themeController.isDarkMode.isTrue ?
              ThemeData.dark().scaffoldBackgroundColor: null,
            body: FutureBuilder(
              future: controller.getTicketAnswers(ticketId: ticket.ticketId),
              builder: (context, index) {
                return SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: controller.ticketsMessages.isNotEmpty ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          // controller: controller.scrollController,
                          itemCount: controller.ticketsMessages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: textMessageTile(controller.ticketsMessages[index]),
                            );
                          },
                        ): const Center(
                          child: Text("Say Hello"),
                        ),
                      ),
                      Container(
                        height: Get.height / 13,
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                  enabled: controller.isLoading.isFalse,
                                  decoration: InputDecoration.collapsed(
                                    filled: true,
                                    hintText: 'Type here...',
                                    hintStyle: TextStyle(
                                      color: themeController.isDarkMode.isTrue ?
                                      ThemeData.light().scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
                                    ),
                                    fillColor: themeController.isDarkMode.isTrue ?
                                    ThemeData.dark().scaffoldBackgroundColor:
                                    ThemeData.light().scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 05),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => controller.isLoading.isFalse ?
                                  controller.onEmojiShowChanged(context): null,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image(
                                      image: const AssetImage("assets/images/emoji.png"),
                                      color: controller.isLoading.isFalse ?
                                      controller.emojiShowing.value ? Colors.blueAccent: null: Colors.red,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 05,
                                ),
                                if(controller.isLoading.isFalse)
                                  GestureDetector(
                                    onTap: ()=> controller.onSend(ticket.ticketId),
                                    child: const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image(
                                        image: AssetImage("assets/images/send.png"),
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
                                  ),
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
                );
              }
            ),
          );
          }
        );
      }
    );
  }

  Widget textMessageTile(TicketModel ticket) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
      if(ticket.sentByUser == 1) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                "You",
                style: TextStyle(
                  color: themeController.isDarkMode.isTrue ?
                  ThemeData.light().scaffoldBackgroundColor: null,
                ),
              ),
            ),
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
                width: kIsWeb ? 15.w : Get.width / 1.6,
                child: Text(
                  "${ticket.message}",
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
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "Admin",
                style: TextStyle(
                  color: themeController.isDarkMode.isTrue ?
                  ThemeData.light().scaffoldBackgroundColor: null,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10, right: 30),
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
                width: kIsWeb ? 15.w : Get.width / 1.6,
                child: Text(
                  "${ticket.message}",
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
        );
      }
    });
  }

// void updateTicket() {
  //   Query q = _refUserTickets.orderByChild("id").equalTo(widget.ticket.id);
  //   q.once().then((DataSnapshot snapshot) {
  //     print(snapshot.value);
  //     String id = getUserTicketId(snapshot);
  //     _refUserTickets.child(id).set(widget.ticket.toJson()).then((s) {
  //       _refTickets
  //           .child(widget.ticket.id)
  //           .set(widget.ticket.toJson())
  //           .then((a) {
  //         Navigator.pop(context);
  //       });
  //     });
  //   });
  //   //
  // }

  // String getUserTicketId(DataSnapshot snapshot) {
  //   String snapStr = snapshot.value.toString();
  //   int initialIndex = snapStr.lastIndexOf('id');
  //   String substringFromId = snapStr.substring(initialIndex + 4);
  //   String id;
  //   try {
  //     print(snapStr.substring(initialIndex));
  //     id = substringFromId.substring(0, substringFromId.lastIndexOf(','));
  //     print('id in first try: $id');
  //     if (id.length > 5) {
  //       id = substringFromId.substring(0, substringFromId.indexOf(','));
  //       id = id.replaceAll('}', '');
  //       print('id in first try and if: $id');
  //     }
  //   } catch (e) {
  //     try {
  //       id = substringFromId.substring(0, substringFromId.lastIndexOf('}'));
  //       id = id.replaceAll('}', '');
  //       print('id in sechond try: $id');
  //     } catch (e) {
  //       id = null;
  //     }
  //   }
  //   return id;
  // }
}