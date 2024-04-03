
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nybal/Widgets/dialogs.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/conversation_model.dart';
import 'package:nybal/models/message_model.dart';
import 'package:nybal/utils/functions.dart';
import 'package:nybal/utils/validators.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user_model.dart';
import '../repository/repository.dart';
import '../routes/routes.dart';
import '../socket/socket.io.dart';
import '../utils/utility.dart';

class ChatController extends GetxController {
  final UserController userController = Get.find<UserController>();
  RxBool isChatBoxOpened = RxBool(false);
  RxBool isBlockMenuOpened = RxBool(false);
  RxBool isLoading = RxBool(false);
  var selectedConversation = ConversationModel();
  // Message textField controller
  TextEditingController msg = TextEditingController();
  // Used for scrolling to the last msg
  final ScrollController scrollController = ScrollController();
  RxBool textFieldHaveContent = RxBool(false);
  // Used for online status visibility change
  RxBool isOnlineStatusVisible = RxBool(false);
  // Used for hiding and showing stickers
  bool isShowSticker = false;
  // Used for hiding and showing emojis
  RxBool emojiShowing = RxBool(false);
  // Used for determining if voice is recording
  RxBool isRecording = RxBool(false);
  // Used for determining if voice is playing
  RxBool isPlaying = RxBool(false);
  // RxBool mPlaybackReady = RxBool(false);

  // Selected conversations
  List<int> selectedConversations = List.empty(growable: true);
  List<int> selectedConversationsIds = List.empty(growable: true);

  // Audio Recorder
  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  RxBool isMPlayerInitialized = RxBool(false);
  Codec codec = Codec.aacMP4;
  String mPath = 'tau_file.mp4';

  // Emoji Picker controller
  final TextEditingController emojiPickerCTR = TextEditingController();

  // Image Picker
  final ImagePicker imgPicker = ImagePicker();
  late Directory cacheDir;
  CroppedFile? imageFile;

  Map<dynamic, dynamic> allUser = {};
  Map<dynamic, dynamic> allMessage = {};
  Map<dynamic, dynamic> chatUser = {};
  // bool isLogin = false;
  // String isLoaclId = "";

  // List<SocketUser>? socketUsers;
  RxList socketUsers = RxList();
  Future<void> onInitSocket() async {
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('allUserMessages', (data) {
      if(data != false) {
        try {
          List<dynamic> jsonList = data;
          List<MessageModel> messages = jsonList.map((json) => MessageModel.fromJson(json)).toList();
          selectedConversation.messages = messages;
        }
        catch (exception) {
          log("Exception on all user messages socket $exception data: $data");
        }finally {
          update();
        }
      }
    });
    socket.on('onlineStatus', (data) {
      if(data != false) {
        // Map<String, dynamic> typedResponse = data;
        // List<SocketUser> userList = typedResponse.values.map((userData) {
        //   return SocketUser.fromJson(userData);
        // }).toList();
        List<dynamic> userList = data;
        socketUsers.value = userList;
        update();
      }
      log("Online status: $data");
    });
    socket.on("userLoggden", (data) {
      log("user login $data");
      // isLogin = true;
      // update();
    });
    socket.on("userAlreadyLogin", (data) {
      // isLogin = true;
      // update();
    });
    socket.on("allUser", (data) {
      allUser.addAll(data);
      // update();
    });
    socket.on("messageSent", (data) {
      allMessage.addAll(data);
      log("message sent");
      // update();
    });
    socket.on("typing", (data) {
      log('user is typing');
      // update();
    });
    socket.on("stopTyping", (data) {
      log('user stopped Typing');
      // update();
    });
    handleUserOnlineStatus();
  }

  bool isUserOnline(int userId) {
    return socketUsers.any((user) => user == userId);
  }

  List<UserDataModel> countOnlineUsers(List<UserDataModel> allUsers) {
    List<UserDataModel> onlineUsersList = allUsers.where((user) => socketUsers.contains(user.id)).toList();
    // int onlineUsersCount = onlineUsersList.length;

    return onlineUsersList;
  }

  bool isMsgSentByMe({int? fromId}) {
    if(fromId != null && fromId == userController.userData.user?.id) {
      return true;
    } else {
      return false;
    }
  }

  // List msgData = [
  //   // {"text": "Hello Bro How u doing today", "type": "text"},
  // ].obs;

  onSend(ConversationModel conversation, BuildContext context) async {
    if (isRecording.value) {
      await mRecorder!.stopRecorder().then((value) async {
        File voiceFile = File(value!);
        Uint8List audioBytes = await voiceFile.readAsBytes();
        String base64string = base64.encode(audioBytes);
        socket.emit("newSms", {
          "toId": conversation.toUserId,
          "fromId": conversation.fromUserId,
          "text": msg.text,
          "media": "data:audio/mp4;base64,$base64string",
          "mediaType": "mp4",
          "cId": conversation.conversationId
        });
        isRecording.value = false;
        selectedConversation.messages?.add(
          MessageModel(
            messageText: '',
            fromId: conversation.fromUserId!,
            media: '',
            mediaType: 'mp4',
            receiver: conversation.firstName.toString(),
            receiverProfilePic: conversation.profilePic.toString(),
            sender: userController.userData.user!.firstName.toString(),
            senderProfilePic: userController.userData.user!.profilePic.toString(),
            toId: conversation.toUserId!,
            // sentAt: DateTime.now(),
          ),
        );
        scrollToLastItem();
      });
    } else {
      if (msg.text.isNotEmpty) {
        socket.emit("newSms", {
          "toId": !isAuthenticatedUser(conversation.toUserId!) ? conversation.toUserId!: conversation.fromUserId!,
          "fromId": isAuthenticatedUser(conversation.fromUserId!) ? conversation.fromUserId!: conversation.toUserId!,
          "text": msg.text,
          "cId": conversation.conversationId
        });
        selectedConversation.messages?.add(
          MessageModel(
            messageText: msg.text,
            fromId: isAuthenticatedUser(conversation.fromUserId!) ? conversation.fromUserId!: conversation.toUserId!,
            media: '',
            mediaType: '',
            receiver: conversation.firstName.toString(),
            receiverProfilePic: conversation.profilePic.toString(),
            sender: userController.userData.user!.firstName.toString(),
            senderProfilePic: userController.userData.user!.profilePic.toString(),
            toId: !isAuthenticatedUser(conversation.toUserId!) ? conversation.toUserId!: conversation.fromUserId!,
            // toId: conversation.toUserId!,
          ),
        );
        scrollToLastItem();
        // msgData.add({"text": msg.text, 'type': "text"});
      } else {
        return;
      }
    }
    msg.clear();
    emojiShowing.value = false;
    FocusScope.of(context).unfocus();
    scrollToLastItem();
    update();
  }

  bool isAuthenticatedUser(int userId) {
    if(userController.userData.user!.id! == userId) {
      return true;
    } else {
      return false;
    }
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

  Future<void> onVoiceRecord() async {
    if (isRecording.value) {
      await mRecorder!.stopRecorder().then((value) {
        print(value);
        isRecording.value = false;
        update();
      });
    } else {
      mRecorder!.startRecorder(
        toFile: mPath,
        codec: codec,
        audioSource: AudioSource.microphone,
      ).then((value) {
        print("value");
        isRecording.value = true;
        update();
      });
    }
  }

  // onPlay() {
  //   if (isPlaying.isTrue) {
  //     mPlayer!.stopPlayer().then((value) {
  //       isPlaying.value = false;
  //       update();
  //     });
  //   } else {
  //     // assert(mPlayerIsInited &&
  //     //     mplaybackReady &&
  //     //     mRecorder!.isStopped &&
  //     //     mPlayer!.isStopped);
  //     mPlayer!.startPlayer(
  //       fromURI: mPath,
  //       //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
  //       whenFinished: () {
  //         isPlaying.value = false;
  //         update();
  //       }).then((value) {
  //       isPlaying.value = true;
  //       update();
  //     });
  //   }
  // }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await mRecorder!.openRecorder();
    if (!await mRecorder!.isEncoderSupported(codec) && kIsWeb) {
      codec = Codec.opusWebM;
      String fileName = generateRandomFileName();
      mPath = fileName;
      print(mPath);
      // audioFiles.add(mPath);

      if (!await mRecorder!.isEncoderSupported(codec) && kIsWeb) {
        isMPlayerInitialized.value = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    isMPlayerInitialized.value = true;
  }

  // pickFile() async {
  //   FilePickerResult? image = await FilePicker.platform.pickFiles();
  //   if(image != null) {
  //     for(int i = 0; i < image.files.length; i++) {
  //       String base64string = await imageToBase64(filePath: image.files[i].path!);
  //       socket.emit("newSms", {
  //         "toId": !isAuthenticatedUser(selectedConversation.toUserId!) ? selectedConversation.toUserId!: selectedConversation.fromUserId!,
  //         "fromId": isAuthenticatedUser(selectedConversation.fromUserId!) ? selectedConversation.fromUserId!: selectedConversation.toUserId!,
  //         "text": msg.text,
  //         "media": base64string,
  //         "mediaType": "jpg",
  //         "cId": selectedConversation.conversationId,
  //       });
  //       selectedConversation.messages?.add(
  //         MessageModel(
  //           messageText: image.files[0].path!,
  //           fromId: selectedConversation.fromUserId!,
  //           media: '',
  //           mediaType: 'image',
  //           receiver: selectedConversation.firstName.toString(),
  //           receiverProfilePic: selectedConversation.profilePic.toString(),
  //           sender: userController.userData.user!.firstName.toString(),
  //           senderProfilePic: userController.userData.user!.profilePic.toString(),
  //           toId: selectedConversation.toUserId!,
  //         ),
  //       );
  //     }
  //     // msgData.add({"text": image.files[0].path, 'type': "image"});
  //     scrollToLastItem();
  //     update();
  //   }
  // }

  Future<bool> selectImage({required BuildContext context, required ImageSource source}) async {
    try {
      XFile? pickedFile = await imgPicker.pickImage(source: source);
      if (pickedFile != null) {
        bool isSelected = await cropImage(context, pickedFile);
        if(isSelected) {
          String base64string = await imageToBase64(filePath: imageFile!.path);
          socket.emit("newSms", {
            "toId": !isAuthenticatedUser(selectedConversation.toUserId!) ? selectedConversation.toUserId!: selectedConversation.fromUserId!,
            "fromId": isAuthenticatedUser(selectedConversation.fromUserId!) ? selectedConversation.fromUserId!: selectedConversation.toUserId!,
            "text": msg.text,
            "media": base64string,
            "mediaType": "jpg",
            "cId": selectedConversation.conversationId,
          });
          selectedConversation.messages?.add(
            MessageModel(
              messageText: imageFile!.path,
              fromId: selectedConversation.fromUserId!,
              media: '',
              mediaType: 'image',
              receiver: selectedConversation.firstName.toString(),
              receiverProfilePic: selectedConversation.profilePic.toString(),
              sender: userController.userData.user!.firstName.toString(),
              senderProfilePic: userController.userData.user!.profilePic.toString(),
              toId: selectedConversation.toUserId!,
            ),
          );
        }
      }
      return false;
    } catch (e) {
      print('Error picking image: $e');
      return false;
    }
  }

  Future<bool> cropImage(BuildContext context, XFile file) async{
    ImageCropper imgCropper = ImageCropper();
    CroppedFile? croppedImage = await imgCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
      uiSettings: [
        WebUiSettings(
          context: context,
          boundary: CroppieBoundary(
            height: 50.h.toInt(),
            width: 50.w.toInt(),
          ),
          viewPort: CroppieViewPort(
            height: 40.h.toInt(),
            width: 40.w.toInt(),
          ),
        ),
      ],
    );

    if(croppedImage != null){
      imageFile = croppedImage;
      update();
      return true;
    }
    return false;
  }


  onMessageFieldTap() {
    emojiShowing.value = false;
    update();
  }

  onChatBoxOpenChanged(bool value) {
    isChatBoxOpened.value = value;
    update();
  }

  onEmojiShowChanged(BuildContext context) {
    emojiShowing.value = !emojiShowing.value;
    FocusScope.of(context).unfocus();
    update();
  }

  // bool isProfileView = false;
  isProfileViewf(bool val) {
    // isProfileView = val;
    update();
  }

  int selectedIndex = 1;

  void handleIndexChanged(int i) {
    isProfileViewf(false);
    selectedIndex = i;
    update();
  }

  void scrollToLastItem() {
    try {
      // scrollController.jumpTo(scrollController.position.maxScrollExtent);
      if(selectedConversation.messages != null) {
        int? itemCount = selectedConversation.messages?.length;
        int? lastIndex = itemCount !- 1;
        scrollController.animateTo(
          lastIndex * 100.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      } else {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    } catch (e) {}
  }

  void scrollToFirstItem() {
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  }

  String generateRandomFileName() {
    final random = math.Random.secure();
    final bytes = List<int>.generate(10, (_) => random.nextInt(256));
    final base64Str = base64Url.encode(bytes);
    return base64Str.replaceAll(RegExp('[^a-zA-Z0-9]'), '');
  }

  void getCacheDirectory() async {
    cacheDir = await getTemporaryDirectory();
    update();
  }

  Future<ConversationModel?> createConversation({required int fromUserId, required int toUserId}) async {
    ConversationModel? conversation = await Repository().createUserConversation(
      fromUserId: fromUserId,
      toUserId: toUserId,
    );
    if(conversation != null) {
      log("conversation created");
      selectedConversation = conversation;
      update();
      return conversation;
    }
    return null;
  }

  Future<ConversationModel?> getIndividualConversation({required int toUserId}) async {
    isLoading(true);
    ConversationModel? conversation = await Repository().getIndividualConversation(
      toUserId: toUserId,
    );
    if(conversation != null) {
      isLoading(false);
      log("got conversation");
      selectedConversation = conversation;
      update();
      return conversation;
    }
    isLoading(false);
    return null;
  }

  Future<ConversationModel?> handleUserConversation({required int fromUserId, required int toUserId}) async {
    if(selectedConversation.conversationId == null) {
      ConversationModel? conversationModel = await getIndividualConversation(
        toUserId: toUserId,
      );
      print("check from id$fromUserId toId:$toUserId");
      if(conversationModel != null) {
        return conversationModel;
      } else {
        ConversationModel? newConversation = await createConversation(
          fromUserId: fromUserId,
          toUserId: toUserId,
        );
        if(newConversation != null) {
          return newConversation;
        }

        return null;
      }
    } else {
      return selectedConversation;
    }
  }

  void onConversationLongPress(int index, conversationId) {
    if(!selectedConversations.contains(index)){
      selectedConversations.add(index);
      selectedConversationsIds.add(conversationId);
      log("on conversation long press $selectedConversationsIds");
      update();
    }
  }

  onConversationSelect(int index, conversationId, bool? value) {
    if(selectedConversations.contains(index)){
      selectedConversations.removeWhere((val) => val == index);
      selectedConversationsIds.removeWhere((element) => element == conversationId);
    } else {
      selectedConversations.add(index);
      selectedConversationsIds.add(conversationId);
    }
    log("on conversation select $selectedConversationsIds");
    update();
  }

  onConversationDelete(int index, int? conversationID) async {
    Dialogs.showLoadingDialog();
    try {
      if(conversationID != null) {
        await Repository().deleteSingleConversation(
          conversationId: conversationID,
        ).then((value) {
          selectedConversations.removeWhere((val) => val == index);
          selectedConversationsIds.removeWhere((element) => element == conversationID);
          update();
        });
      } else {
        showShortToast("Cant delete conversation");
      }
    } finally {
      Get.back();
    }
  }

  markAsReadConversation(int? conversationID) async {
    Dialogs.showLoadingDialog();
    try {
      if(conversationID != null) {
        await Repository().markAsReadConversation(
          conversationId: conversationID,
        );
      } else {
        showShortToast("Cant mark as seen");
      }
    } finally {
      Get.back();
      update();
    }
  }

  markSelectedConversationsAsSeen() async {
    Dialogs.showLoadingDialog();
    try {
      if(selectedConversationsIds.isNotEmpty) {
        await Repository().markAsReadSelectedConversations(
          conversationIds: selectedConversationsIds,
        );
      } else {
        showShortToast("Cant mark as seen");
      }
    } finally {
      Get.back();
      update();
    }
  }


  onSelectedConversationsDelete() async {
    Dialogs.showLoadingDialog();
    try {
      if(selectedConversationsIds.isNotEmpty) {
        await Repository().deleteSelectedConversations(
          conversationIds: selectedConversationsIds,
        ).then((value) => {
          selectedConversationsIds.clear(),
          selectedConversations.clear()
        });

      } else {
        showShortToast("Cant delete conversations");
      }
    } finally {
      Get.back();
      update();
    }
  }


  void onOnlineStatusChanged(bool value) async {
    bool? onlineStatus = await Repository().changeUserOnlineStatus(value);
    if(onlineStatus != null) {
      isOnlineStatusVisible.value = onlineStatus;
      userController.userData.user?.onlineStatus = onlineStatus;
      handleUserOnlineStatus();
      update();
    }
  }

  void handleUserOnlineStatus() {
    if(userController.userData.user != null) {
      if(userController.userData.user?.onlineStatus == true) {
        socket.emit("onlineIndicator",
          userController.userData.user?.id,
        );
      } else {
        socket.emit("disableOnlineIndicator",
          userController.userData.user?.id,
        );
      }
    }
  }

  void onDialCall({
    required bool isVideoCall,
    required int userId
  }) async {
    final data = await AppUtility.readChannelDataFromLocalStorage();
    // _channelId = data['channelId'].toString();
    // setAgoraUid = data['agoraUid'].toString();
    bool? result = await Repository().dialCall(
      isVideoCall: isVideoCall,
      userId: userId,
      channelId: data['channelId'].toString(),
      agoraUid: data['agoraUid'].toString(),
    );
    if(result != null) {
      Get.toNamed(Routes.callView);
    }
  }

  @override
  void dispose() {
    mPlayer!.closePlayer();
    mPlayer = null;
    mRecorder!.closeRecorder();
    mRecorder = null;
    emojiPickerCTR.dispose();
    super.dispose();
  }

  onUserBlockMenuChanged() {
    isBlockMenuOpened.value = !isBlockMenuOpened.value;
    update();
  }

  clearAll() {
    isBlockMenuOpened = RxBool(false);
    update();
  }

  UserDataModel? getChatUser() {
    int? fromId = selectedConversation.fromUserId;
    int? toUserId = selectedConversation.toUserId;

    if(fromId != null && !isAuthenticatedUser(fromId)) {
      return userController.usersList.firstWhere((element) => element.id == fromId);
    } else {
      return userController.usersList.firstWhere((element) => element.id == toUserId);
    }
  }


}
