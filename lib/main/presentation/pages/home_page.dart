import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hyll/main/presentation/style/colors.dart';
import 'package:hyll/main/presentation/widgets/adventure_widget.dart';
import 'package:hyll/main/presentation/widgets/loading_widget.dart';
import 'package:hyll/main/shared/providers.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/model/hyll_states.dart';
import '../style/style.dart';
import '../widgets/activity_widget.dart';
import 'adventure_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScrollController scrollController = ScrollController();
  int selectedActivity = 0;

  @override
  void initState() {
    super.initState();

    // Attach the scroll listener to fetch the next page when reaching the bottom
    scrollController.addListener(() {
      if (scrollController.position.pixels >
              scrollController.position.maxScrollExtent / 1.5 &&
          scrollController.position.pixels != 0 &&
          ref.read(hyllNotifierProvider).state != AdventureState.loading &&
          ref.read(hyllNotifierProvider).nextPageUrl != null) {
        debugPrint("loading");
        ref.read(hyllNotifierProvider.notifier).fetchNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final adventureData = ref.watch(hyllNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Text("Explore",
            style: fontPoppinsW400(appcolor: AppColors.textColor)),
        actions: [
          SvgPicture.asset("assets/svg/filter.svg"),
          const Gap(15),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.bgColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppColors.white)),
                  fillColor: AppColors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppColors.white)),
                  hintText: "Mount Bruno",
                  hintStyle: fontPoppinsW400(appcolor: Colors.grey)
                      .copyWith(fontSize: 12)),
            ),
            const Gap(20),
            SizedBox(
              height: 30,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Gap(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: _activityItemsCount(adventureData),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _buildActivity(adventureData, index)),
            ),
            const Gap(20),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Gap(10),
                shrinkWrap: true,
                controller: scrollController,
                itemCount: _itemsCount(adventureData),
                itemBuilder: (context, index) {
                  return _buildList(adventureData, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _itemsCount(HyllData data) {
    return switch (data.state) {
      (AdventureState.loading) => data.adventures.length + 15,
      (AdventureState.loaded) => data.adventures.length,
      (AdventureState.error) => 1
    };
  }

  int _activityItemsCount(HyllData data) {
    return switch (data.state) {
      (AdventureState.loading) => 10,
      (AdventureState.loaded) => data.activites.length,
      (AdventureState.error) => 0
    };
  }

  Widget _buildActivity(HyllData data, int index) {
    return switch (data.state) {
      (AdventureState.loading) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 15,
            width: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
          ),
        ),
      (AdventureState.loaded) => ActivityWidget(
          activites: data.activites,
          index: index,
          selectedActivity: selectedActivity,
          onTap: () {
            setState(() {
              selectedActivity = index;
            });
          },
        ),
      (AdventureState.error) => const SizedBox()
    };
  }

  Widget _buildList(HyllData data, int index) {
    return switch (data.state) {
      (AdventureState.loading) => data.adventures.length <= index
          ? const ShimmerLoading()
          : GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdventurePage(
                          id: data.adventures[index].id.toString()),
                    ));
              },
              child: AdventureWidget(
                imageUrl: data.adventures[index].contents![0].contentUrl!,
                title:
                    data.adventures[index].startingLocation!.name ?? "UnNamed",
                primaryDescription:
                    data.adventures[index].startingLocation!.subtitle ??
                        "Liechtenstin",
                tags: data.adventures[index].tags!,
                id: data.adventures[index].id.toString(),
              ),
            ),
      (AdventureState.loaded) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AdventurePage(id: data.adventures[index].id.toString()),
                ));
          },
          child: AdventureWidget(
            imageUrl: data.adventures[index].contents![0].contentUrl!,
            title: data.adventures[index].startingLocation!.name ?? "UnNamed",
            primaryDescription:
                data.adventures[index].startingLocation!.subtitle ??
                    "Liechtenstin",
            tags: data.adventures[index].tags!,
            id: data.adventures[index].id.toString(),
          ),
        ),
      (AdventureState.error) => const Center(
          child: Text("An error occurred while fetching data."),
        ),
    };
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
