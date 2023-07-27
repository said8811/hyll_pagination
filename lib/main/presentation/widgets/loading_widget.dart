import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(100),
            ),
            const Gap(20),
            Container(
              height: 20,
              margin: const EdgeInsets.only(right: 100),
              color: Colors.white,
            ),
            const Gap(20),
            Container(
              height: 20,
              margin: const EdgeInsets.only(right: 160),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
