import 'package:flutter/material.dart';
import 'package:hyll/main/presentation/style/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPLayPage extends StatefulWidget {
  final String videoUrl;
  const VideoPLayPage({super.key, required this.videoUrl});

  @override
  State<VideoPLayPage> createState() => _VideoPLayPageState();
}

class _VideoPLayPageState extends State<VideoPLayPage> {
  late VideoPlayerController controller;
  bool isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )
      ..addListener(() => setState(() {
            if (controller.value.position >= controller.value.duration) {
              isVideoEnded = true;
            }
          }))
      ..initialize().then((_) {
        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value.isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
              Positioned(
                  top: 15,
                  left: 1,
                  child: Container(
                    color: AppColors.primary,
                    height: 6,
                    width: 200,
                    child: VideoProgressIndicator(controller,
                        allowScrubbing: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20)),
                  )),
              if (isVideoEnded)
                Positioned(
                    right: 1,
                    top: 1,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.cancel,
                        size: 25,
                        color: AppColors.white,
                      ),
                    ))
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ),
      );
    }
  }
}
