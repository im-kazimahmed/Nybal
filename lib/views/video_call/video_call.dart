import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class videoCall extends StatefulWidget {
  const videoCall({super.key});

  @override
  State<videoCall> createState() => _videoCallState();
}

class _videoCallState extends State<videoCall> {
  bool isPreviewPaused = false;
  bool isExpanded = false;
  bool isMuted = false;

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image
  loadCamera() async {
    cameras = await availableCameras();
    if (cameras == null) {
      cameras = await availableCameras();
    } else {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.red,
            child: controller == null ? const Text("") : !isExpanded ? isPreviewPaused ? Stack(
              children: [
                CameraPreview(controller!),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ): CameraPreview(controller!):
            Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Image(
                    image: AssetImage("assets/images/bg_man.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 25,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: Image(image: AssetImage("assets/images/expand.png")),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(133, 158, 158, 158),
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(05),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                if(!isExpanded)
                  Stack(
                    children: [
                      Container(
                        height: Get.height / 3.5,
                        width: Get.width / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: const Image(
                            image: AssetImage("assets/images/bg_man.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 05,
                        left: 05,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: const SizedBox(
                            height: 40,
                            width: 40,
                            child: Image(image: AssetImage("assets/images/expand.png")),
                          ),
                        ),
                      )
                    ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: Get.height / 3.5,
              width: Get.width,
              // color: Colors.red,
              child: Column(
                children: [
                  const Text(
                    "سارة",
                    style: TextStyle(
                      fontSize: 35,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                      fontFamily: "myFontLight",
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 08,
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(width: 05),
                      Text(
                        "09:12",
                        style: TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          fontFamily: "myFontLight",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMuted = !isMuted;
                          });
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isMuted ? Colors.white: Colors.grey.withOpacity(0.4),
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 167, 167, 167),
                            ),
                            borderRadius: BorderRadius.circular(100)),
                            child: Image(
                              image: const AssetImage("assets/images/mic.png"),
                              color: isMuted ? Colors.black: Colors.white,
                            ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 65,
                          width: 65,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Image(
                              image: AssetImage("assets/images/call.png")),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPreviewPaused = !isPreviewPaused;
                            if (isPreviewPaused) {
                              controller?.pausePreview();
                            } else {
                              controller?.resumePreview();
                            }
                          });
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isPreviewPaused ?
                            Colors.white: Colors.grey.withOpacity(0.4),
                            border: Border.all(width: 1,
                              color: const Color.fromARGB(255, 167, 167, 167),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image(
                            image: const AssetImage("assets/images/vdo.png"),
                            color: isPreviewPaused ? Colors.black: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
