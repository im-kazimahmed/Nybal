// import 'dart:async';
// import 'dart:io';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:get/get.dart';
// import 'package:nybal/config/app_config.dart';
// import 'package:nybal/repository/repository.dart';
// import '../helpers/local_data_helper.dart';
// import '../helpers/permissions.dart';
// import '../services/auth_service.dart';
// import '../utils/strings.dart';
// import '../utils/utility.dart';
//
// class ChannelController extends GetxController {
//   static ChannelController get find => Get.find();
//
//   final _auth = AuthService.find;
//
//   late final RtcEngine _rtcEngine;
//   late final RtcEngineEventHandler _eventHandler;
//
//   bool _audioMuted = false;
//   bool _videoMuted = false;
//   bool _isConnecting = false;
//   bool _switchRender = false;
//   bool _showControls = true;
//   bool _isJoined = false;
//
//   late String _channelId;
//   String _agoraUid = '0';
//
//   String _token = '';
//
//   final List<int> _participants = [];
//
//   bool get audioMuted => _audioMuted;
//
//   bool get videoMuted => _videoMuted;
//
//   bool get isConnecting => _isConnecting;
//
//   bool get switchVideo => _switchRender;
//
//   bool get showControls => _showControls;
//
//   bool get isJoined => _isJoined;
//
//   List<int> get participants => _participants;
//
//   String get channelId => _channelId;
//   String get agoraUid => _agoraUid;
//   set setAgoraUid(String value) => _agoraUid = value;
//
//   RtcEngine get rtcEngine => _rtcEngine;
//
//   RtcEngineEventHandler get eventHandler => _eventHandler;
//
//   Future<void> _getRtcToken() async {
//     AppUtility.printLog("Get RTC Token Request...");
//     final data = await AppUtility.readChannelDataFromLocalStorage();
//     _channelId = data['channelId'].toString();
//     setAgoraUid = data['agoraUid'].toString();
//     _auth.getChannelInfo();
//     try {
//       String? response = await Repository().getRctToken(_channelId, agoraUid);
//       if(response != null) {
//         _token = response;
//       }
//     } on SocketException {
//       AppUtility.printLog(StringValues.internetConnError);
//       // AppUtility.showSnackBar(
//       //     StringValues.internetConnError, StringValues.error);
//     } on TimeoutException {
//       AppUtility.printLog(StringValues.connTimedOut);
//       // AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
//     } on FormatException catch (e) {
//       AppUtility.printLog(StringValues.formatExcError);
//       AppUtility.printLog(e);
//       // AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
//     } catch (exc) {
//       AppUtility.printLog(StringValues.errorOccurred);
//       AppUtility.printLog(exc);
//       // AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
//     }
//   }
//
//   void _addAgoraEventHandlers() async {
//     _eventHandler = RtcEngineEventHandler(
//       onError: (code, message) {
//         final message = 'onError: $code';
//         AppUtility.printLog(message);
//         // AppUtility.showSnackBar(message, 'error');
//       },
//       onJoinChannelSuccess: (connection, stats) {
//         _isJoined = true;
//         update();
//         final message = 'onJoinChannel: $connection, stats: $stats';
//         AppUtility.printLog(message);
//         // AppUtility.showSnackBar("You joined.", 'success');
//       },
//       onUserJoined: (connection, remoteUid, elapsed) {
//         final message = 'userJoined: $remoteUid';
//         AppUtility.printLog(message);
//         _participants.add(remoteUid);
//         update();
//         // AppUtility.showSnackBar("$remoteUid joined.", 'success');
//       },
//       onUserOffline: (connection, remoteUid, reason) {
//         final message = 'userOffline: $remoteUid reason: $reason';
//         AppUtility.printLog(message);
//         _participants.removeWhere((element) => element == remoteUid);
//         update();
//         // AppUtility.showSnackBar("$remoteUid left.", 'warning');
//       },
//       onLeaveChannel: (connection, stats) {
//         final message = 'leaveChannel: $connection stats: ${stats.toJson()}';
//         AppUtility.printLog(message);
//         _participants.clear();
//         update();
//       },
//       onConnectionLost: (connection) {
//         const message = "Connection is poor or lost.";
//         AppUtility.printLog(message);
//         // AppUtility.showSnackBar(message, 'warning');
//       },
//       onConnectionInterrupted: (connection) {
//         const message = "Connection is interrupted.";
//         AppUtility.printLog(message);
//         // AppUtility.showSnackBar(message, 'warning');
//       },
//       onUserMuteAudio: (connection, remoteUid, audioMuted) {
//         String message;
//         if (audioMuted) {
//           message = '$remoteUid muted audio.';
//         } else {
//           message = '$remoteUid unmuted audio.';
//         }
//         AppUtility.printLog(message);
//         // AppUtility.showSnackBar(message, 'warning');
//       },
//       onUserMuteVideo: (connection, remoteUid, videoMuted) {
//         String message;
//         if (videoMuted) {
//           message = '$remoteUid muted video.';
//         } else {
//           message = '$remoteUid unmuted video.';
//         }
//         AppUtility.printLog(message);
//         // AppUtility.showSnackBar(message, 'warning');
//       },
//     );
//     _rtcEngine.registerEventHandler(_eventHandler);
//   }
//
//   void leaveChannel() async {
//     await _rtcEngine.leaveChannel();
//     _rtcEngine.unregisterEventHandler(_eventHandler);
//     update();
//     Get.back();
//     // RouteManagement.goToBack();
//   }
//
//   void toggleMuteVideo() {
//     _videoMuted = !_videoMuted;
//     if (_videoMuted) {
//       _rtcEngine.disableVideo();
//     } else {
//       _rtcEngine.enableVideo();
//     }
//     _rtcEngine.muteLocalVideoStream(_videoMuted);
//
//     AppUtility.printLog("Camera: $_videoMuted");
//     update();
//   }
//
//   void toggleMuteAudio() {
//     _audioMuted = !_audioMuted;
//     if (_audioMuted) {
//       _rtcEngine.disableAudio();
//     } else {
//       _rtcEngine.enableAudio();
//     }
//     _rtcEngine.muteLocalAudioStream(_audioMuted);
//     AppUtility.printLog("Mic: $_audioMuted");
//     update();
//   }
//
//   void switchCamera() {
//     _rtcEngine.switchCamera();
//     update();
//   }
//
//   void switchVideoRender() {
//     _switchRender = !_switchRender;
//     update();
//   }
//
//   void toggleShowControls() {
//     _showControls = !_showControls;
//     update();
//   }
//
//   Future<void> _initAgoraRtcEngine() async {
//     // await Wakelock.enable();
//     _rtcEngine = createAgoraRtcEngine();
//     await _rtcEngine.initialize(
//       const RtcEngineContext(
//         appId: AppConfig.appId,
//       ),
//     );
//
//     _addAgoraEventHandlers();
//
//     await _rtcEngine.enableVideo();
//   }
//
//   Future<void> _init() async {
//     _isConnecting = true;
//     update();
//
//     await _initAgoraRtcEngine();
//
//     var cameraPerm = await AppPermissions.checkCameraPermission();
//     var micPerm = await AppPermissions.checkMicPermission();
//
//     if (!cameraPerm || !micPerm) {
//       Get.back();
//       // RouteManagement.goToBack();
//       return;
//     }
//
//     await _getRtcToken().then((_) async {
//       Map<String, dynamic>? savedChannelData = LocalDataHelper().getUserIncomingChannelId();
//       if(savedChannelData != null) {
//         await _rtcEngine.joinChannel(
//           token: _token,
//           channelId: _channelId,
//           uid: savedChannelData['agora_uid'],
//           options: const ChannelMediaOptions(
//             channelProfile: ChannelProfileType.channelProfileCommunication,
//             clientRoleType: ClientRoleType.clientRoleAudience,
//           ),
//         );
//       } else {
//         await _rtcEngine.joinChannel(
//           token: _token,
//           channelId: _channelId,
//           uid: 0,
//           // uid: int.parse(_auth.agoraUid),
//           options: const ChannelMediaOptions(
//             channelProfile: ChannelProfileType.channelProfileCommunication,
//             clientRoleType: ClientRoleType.clientRoleBroadcaster,
//           ),
//         );
//       }
//
//       _isConnecting = false;
//       update();
//     });
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     try {
//       _channelId = Get.arguments[0]?.toString() ?? _auth.channelId.toString();
//       _videoMuted = Get.arguments[1] ?? false;
//       _audioMuted = Get.arguments[2] ?? false;
//       AppUtility.printLog("Mic: $_audioMuted");
//       AppUtility.printLog("Camera: $_videoMuted");
//     } catch (e) {}
//     _init();
//   }
//
//   @override
//   void onClose() {
//     _rtcEngine.leaveChannel();
//     _rtcEngine.unregisterEventHandler(_eventHandler);
//     super.onClose();
//   }
// }
