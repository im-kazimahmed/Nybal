import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/user_model.dart';
import 'package:nybal/repository/repository.dart';

import '../models/ticket_model.dart';
import '../utils/functions.dart';
import 'navigation_controller.dart';

class SupportSystemController extends GetxController {
  final userController = Get.find<UserController>();
  final navController = Get.find<NavigationController>();

  // Emoji Picker controller
  final TextEditingController emojiPickerCTR = TextEditingController();
  RxBool emojiShowing = RxBool(false);
  RxBool isLoading = RxBool(false);
  var userTickets = <TicketModel>[].obs;
  var ticketsMessages = <TicketModel>[].obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? imageBase64;
  TextEditingController msg = TextEditingController();

  String valueType = "Account and Profile Issues";
  var types = [
    "Account and Profile Issues",
    "Messaging and Communication",
    "Matching and Suggestions",
    "App Performance",
    "Payment and Subscription",
    "Privacy and Security",
    "Safety and Reporting",
    "Technical Support",
    "Other"
  ];

  onMessageFieldTap() {
    emojiShowing.value = false;
    update();
  }

  onEmojiShowChanged(BuildContext context) {
    emojiShowing.value = !emojiShowing.value;
    FocusScope.of(context).unfocus();
    update();
  }

  onBackspacePressed() {
    emojiPickerCTR
      ..text = emojiPickerCTR.text.characters.toString()
      ..selection = TextSelection.fromPosition(
        TextPosition(
          offset: emojiPickerCTR.text.length,
        ),
      );
  }

  void insertTicket() async {
    UserDataModel? user = userController.userData.user;
    if(user != null) {
      var now = DateTime.now().toIso8601String();
      String date = now.split('T')[0];
      String time = now.split('T')[1].split('.')[0];
      TicketModel newTicket = TicketModel(
        userId: user.id,
        title: titleController.text,
        message: descriptionController.text,
        status: "0",
        sentByUser: 1,
        sentByAdmin: 0,
        createdAt: date,
        file: imageBase64 ?? "",
        // type: _valueType,
        // date: date,
        // time: time,
      );
      bool? result = await Repository().createSupportTicket(ticket: newTicket);
      if(result == true) {
        userTickets.add(newTicket);
        titleController.clear();
        descriptionController.clear();
        update();
        navController.handleNavIndexChanged(25);
      }
    }
  }

  pickFile() async {
    FilePickerResult? image = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(image != null) {
      String base64string = await imageToBase64(filePath: image.files[0].path!);
      imageBase64 = base64string;
    }
  }

  // Get User tickets
  Future<List<TicketModel>?> getTickets() async {
    List<TicketModel>? tickets = await Repository().getUsersSupportTickets();
    if(tickets != null) {
      userTickets.value = tickets;
      return tickets;
    } else {
      return null;
    }
  }

  // Get Ticket Messages
  Future<List<TicketModel>?> getTicketAnswers({required int? ticketId}) async {
    if(ticketId != null) {
      List<TicketModel>? tickets = await Repository().getTicketsAnswers(ticketId);
      if(tickets != null) {
        ticketsMessages.value = tickets;
        return tickets;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  List<TicketModel> getTicketMessages(int? ticketId) {
    List<TicketModel> messages = ticketsMessages.where((p0) => p0.ticketId == ticketId || p0.id == ticketId).toList();
    return messages;
  }

  onSend(int? ticketId) async {
    isLoading(true);
    update();
    List<TicketModel>? messages = await Repository().sendAnswerToTicket(
      message: msg.text,
      ticketId: ticketId,
    );
    msg.clear();
    isLoading(false);
    update();
    print("on send $ticketId");
  }

}
