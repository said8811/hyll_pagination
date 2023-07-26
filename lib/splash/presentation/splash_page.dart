import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hyll/main/presentation/pages/home_page.dart';
import 'package:hyll/main/presentation/style/colors.dart';
import 'package:hyll/main/presentation/style/style.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.bgColor),
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LET'S",
                      style: fontPoppinsW300(appcolor: const Color(0xFF425884))
                          .copyWith(fontSize: 25),
                    ),
                    Text(
                      "EXPLORE",
                      style: fontPoppinsW600(appcolor: const Color(0xFF425884))
                          .copyWith(fontSize: 48),
                    ),
                    Text(
                      "THE WORLD",
                      style: fontPoppinsW300(appcolor: const Color(0xFF425884))
                          .copyWith(fontSize: 25),
                    ),
                    Text(
                      " Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Faucibus faucibus tortor,\n suscipit velit phasellus massa.",
                      style: fontPoppinsW300(appcolor: const Color(0xFF425884))
                          .copyWith(fontSize: 10),
                    ),
                    const Gap(48),
                    InkWell(
                      splashColor: AppColors.gradientFirst,
                      onTap: () {
                        Get.off(const HomePage(), transition: Transition.fade);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              AppColors.gradientSecond,
                              AppColors.gradientFirst
                            ])),
                        child: Text(
                          "ENTER",
                          style: fontPoppinsW600(appcolor: AppColors.white)
                              .copyWith(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1150),
                    gradient: RadialGradient(colors: [
                      AppColors.gradientFirst.withOpacity(0.6),
                      AppColors.gradientFirst,
                      AppColors.bgColor
                    ], tileMode: TileMode.mirror)),
                child: Center(
                  child: Image.asset(
                    "assets/images/bg.png",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
