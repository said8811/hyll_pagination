import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/style.dart';

class ActivityWidget extends StatelessWidget {
  final VoidCallback onTap;
  final int selectedActivity;
  final int index;
  final List<String> activites;
  const ActivityWidget({
    super.key,
    required this.onTap,
    required this.selectedActivity,
    required this.index,
    required this.activites,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: index == selectedActivity
                  ? [AppColors.gradientSecond, AppColors.gradientFirst]
                  : [AppColors.white, AppColors.white]),
        ),
        child: Center(
          child: Text(
            activites[index],
            style: fontPoppinsW500(
                    appcolor: index == selectedActivity
                        ? AppColors.white
                        : AppColors.textColor)
                .copyWith(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
