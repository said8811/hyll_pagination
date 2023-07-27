import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyll/main/presentation/style/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hyll/main/presentation/style/style.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class AdventureWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String primaryDescription;
  final List<String> tags;
  final String id;
  VoidCallback? onTap;
  AdventureWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.primaryDescription,
      required this.tags,
      required this.id,
      this.onTap});

  @override
  State<AdventureWidget> createState() => _AdventureWidgetState();
}

class _AdventureWidgetState extends State<AdventureWidget>
    with TickerProviderStateMixin {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.imageUrl.isEmpty)
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 100,
                  ),
                  Gap(10),
                  Text(
                    "No image",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            )
          else
            GestureDetector(
                onTap: widget.onTap,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 400,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          const Gap(20),
          Row(
            children: [
              const Gap(2),
              Column(
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: fontPoppinsW500(appcolor: AppColors.textColor)
                        .copyWith(fontSize: 14),
                  ),
                  const Gap(10),
                  Text(
                    widget.primaryDescription,
                    overflow: TextOverflow.ellipsis,
                    style: fontPoppinsW200(appcolor: AppColors.textColor)
                        .copyWith(fontSize: 10),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(color: AppColors.textColor),
                child: const Text("4.6"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
