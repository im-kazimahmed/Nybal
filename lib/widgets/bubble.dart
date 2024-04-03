import 'package:flutter/material.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:loading_indicator/loading_indicator.dart';

class VoiceMessageBubble extends StatelessWidget {
  const VoiceMessageBubble({
    required this.source,
    required this.isMe,
    required this.meBgColor,
    required this.contactColor,
    Key? key,
  }) : super(key: key);
  final String source;
  final bool isMe;
  final Color meBgColor;
  final Color contactColor;

  @override
  Widget build(BuildContext context) => VoiceMessage(
    meBgColor: meBgColor,
    me: isMe,
    mePlayIconColor: Colors.white,
    meFgColor: AppColors.pinkButton,
    contactFgColor: AppColors.pinkButton,
    contactPlayIconBgColor: Colors.white,
    contactPlayIconColor: Colors.white,
    contactCircleColor: Colors.white,
    contactBgColor: contactColor,
    radius: 10,
    audioSrc: source,
    showDuration: false,
    // formatDuration: (Duration duration) {
    //   return "$duration";
    // },
  );
}


class UserTypingBubble extends StatelessWidget {
  const UserTypingBubble({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 50, minWidth: 0, maxHeight: 40),
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.appBarPurple,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [Colors.white],
            ),
          ),
        ),
      ],
    );
  }
}