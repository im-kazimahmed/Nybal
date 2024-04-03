import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nybal/Widgets/theme_data.dart';

class FullScreenImagePage extends StatelessWidget {
  // final String imageUrl;
  final String imageAsset;
  const FullScreenImagePage({super.key, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: mainClr,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.grey,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: imageAsset,
            child: Image.file(
              File(imageAsset),
              fit: BoxFit.contain,
            ),
          ),
        ),
        // child: Center(
        //   child: Hero(
        //     tag: imageUrl,
        //     child: CachedNetworkImage(
        //       imageUrl: imageUrl,
        //       fit: BoxFit.contain,
        //       placeholder: (context, url) => CircularProgressIndicator(),
        //       errorWidget: (context, url, error) => Icon(Icons.error),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}