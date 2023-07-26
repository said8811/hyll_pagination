import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyll/main/presentation/style/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

class _AdventureWidgetState extends State<AdventureWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.imageUrl.isEmpty)
          Container(
            height: 400,
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
                width: double.infinity,
                height: 400.0,
                decoration: BoxDecoration(
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
            ),
          ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.title,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 24, color: AppColors.black),
          ),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.primaryDescription,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
