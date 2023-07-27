import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    if (controller.value.isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              GestureDetector(
                onLongPress: () => controller.pause(),
                onLongPressEnd: (details) => controller.play(),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.topCenter,
                      color: AppColors.white,
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.98,
                      child: VideoProgressIndicator(controller,
                          allowScrubbing: true,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          colors: VideoProgressColors(
                              playedColor: AppColors.gradientSecond,
                              bufferedColor:
                                  AppColors.primary.withOpacity(0.4))),
                    ),
                  ),
                  const Gap(20)
                ],
              ),
              if (isVideoEnded)
                Positioned(
                    right: 1,
                    top: -12,
                    child: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => Navigator.pop(context),
                        icon: SvgPicture.asset(
                          "assets/svg/close.svg",
                          // ignore: deprecated_member_use
                          color: AppColors.white,
                        )))
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
