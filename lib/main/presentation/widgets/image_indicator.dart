import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyll/main/presentation/style/colors.dart';

class ImageIndicator extends StatelessWidget {
  final int length;
  final int currentindex;
  const ImageIndicator({
    super.key,
    required this.currentindex,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Gap(5),
      itemCount: length > 5 ? 5 : length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Opacity(
        opacity: length == 1 ? 0 : 1,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: length > 5
                ? currentindex == index || currentindex > index && index == 4
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.6)
                : currentindex == index
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
