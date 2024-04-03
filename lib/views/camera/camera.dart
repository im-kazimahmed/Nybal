import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class CustomView extends EmojiPickerBuilder {
  CustomView(Config config, EmojiViewState state) : super(config, state);

  @override
  // ignore: library_private_types_in_public_api
  _CustomViewState createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
  @override
  Widget build(BuildContext context) => EmojiPicker(
        onEmojiSelected: (category, Emoji emoji) {
          // Do something when emoji is tapped (optional)
        },
        onBackspacePressed: () {
          // Do something when the user taps the backspace button (optional)
          // Set it to null to hide the Backspace-Button
        },
        textEditingController:
            null, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        config: const Config(
          columns: 7,
          emojiSizeMax: 32,
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          recentTabBehavior: RecentTabBehavior.RECENT,
          recentsLimit: 28,
          noRecents: Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ), // Needs to be const Widget
          loadingIndicator: SizedBox.shrink(), // Needs to be const Widget
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
        ),
      );
}
