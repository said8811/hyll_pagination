import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hyll/main/presentation/pages/adventure_page.dart';
import 'package:hyll/main/presentation/style/colors.dart';
import 'package:hyll/main/presentation/style/style.dart';
import 'package:hyll/main/presentation/widgets/adventure_widget.dart';

import '../../domain/model/hyll_model.dart';

class AdventuresListView extends StatelessWidget {
  final List<Data> adventures;
  final String activity;
  const AdventuresListView({
    super.key,
    required this.adventures,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          activity,
          style: fontPoppinsW700(appcolor: AppColors.textColor).copyWith(
            fontSize: 20,
          ),
        ),
        const Gap(20),
        ListView.separated(
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: adventures.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.to(
                AdventurePage(id: adventures[index].id.toString()),
                transition: Transition.fade,
              );
            },
            child: AdventureWidget(
                imageUrl: adventures[index].contents![0].contentUrl!,
                title: adventures[index].startingLocation!.name!,
                primaryDescription:
                    adventures[index].startingLocation!.subtitle ??
                        "Liechtenstin",
                id: adventures[index].id.toString()),
          ),
        ),
      ],
    );
  }
}
