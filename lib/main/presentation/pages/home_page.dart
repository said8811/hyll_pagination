import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hyll/main/presentation/style/colors.dart';
import 'package:hyll/main/presentation/widgets/adventures_list.dart';
import 'package:hyll/main/presentation/widgets/loading_widget.dart';
import 'package:hyll/main/shared/providers.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/model/hyll_states.dart';
import '../style/style.dart';
import '../widgets/activity_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ItemScrollController adventurescrollController = ItemScrollController();
  final adventureScrollListener = ItemPositionsListener.create();
  ItemScrollController activityscrollController = ItemScrollController();
  final activityScrollListener = ItemPositionsListener.create();
  int selectedActivity = 0;
  bool isAdventureScrolling = false;

  @override
  void initState() {
    adventureScrollListener.itemPositions.addListener(() {
      final indexes =
          adventureScrollListener.itemPositions.value.map((e) => e).toList();
      if (ref.read(hyllNotifierProvider).state == AdventureState.loaded) {
        if (ref
                    .watch(hyllNotifierProvider)
                    .adventureWithActivity[indexes.first.index]
                    .activity !=
                ref.watch(hyllNotifierProvider).activites[selectedActivity] &&
            !isAdventureScrolling) {
          setState(() {
            selectedActivity = indexes.first.index;
          });
          activityscrollController.scrollTo(
              index: indexes.first.index,
              duration: const Duration(milliseconds: 300));
        }
        if (indexes.any((e) =>
                e.index >=
                ref.watch(hyllNotifierProvider).adventureWithActivity.length -
                    2) &&
            ref.read(hyllNotifierProvider).nextPageUrl != null) {
          ref.watch(hyllNotifierProvider.notifier).fetchNextPage();
        }
      }
    });
    super.initState();
  }

  Future scrollToItem(int index) async {
    isAdventureScrolling = true;
    await adventurescrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 300),
    );
    isAdventureScrolling = false;
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: AppColors.bgColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
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
              child: ScrollablePositionedList.separated(
                  itemScrollController: activityscrollController,
                  itemPositionsListener: activityScrollListener,
                  separatorBuilder: (context, index) => const Gap(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: _activityItemsCount(adventureData),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _buildActivity(adventureData, index)),
            ),
            const Gap(20),
            Expanded(
              child: ScrollablePositionedList.separated(
                separatorBuilder: (context, index) => const Gap(10),
                shrinkWrap: true,
                itemScrollController: adventurescrollController,
                itemPositionsListener: adventureScrollListener,
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
      (AdventureState.loading) => data.adventureWithActivity.length + 15,
      (AdventureState.loaded) => data.adventureWithActivity.length,
      (AdventureState.error) => 1
    };
  }

  int _activityItemsCount(HyllData data) {
    return switch (data.state) {
      (AdventureState.loading) => data.activites.length + 10,
      (AdventureState.loaded) => data.activites.length,
      (AdventureState.error) => 0
    };
  }

  Widget _buildActivity(HyllData data, int index) {
    return switch (data.state) {
      (AdventureState.loading) => index >= data.activites.length
          ? Shimmer.fromColors(
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
            )
          : ActivityWidget(
              activites: data.activites,
              index: index,
              selectedActivity: selectedActivity,
              onTap: () {
                setState(() {
                  selectedActivity = index;
                });
                scrollToItem(index);
              },
            ),
      (AdventureState.loaded) => ActivityWidget(
          activites: data.activites,
          index: index,
          selectedActivity: selectedActivity,
          onTap: () {
            setState(() {
              selectedActivity = index;
              scrollToItem(index);
            });
          },
        ),
      (AdventureState.error) => const SizedBox()
    };
  }

  Widget _buildList(HyllData data, int index) {
    return switch (data.state) {
      (AdventureState.loading) => data.adventureWithActivity.length <= index
          ? const ShimmerLoading()
          : AdventuresListView(
              adventures: data.adventureWithActivity[index].adventures
                  .where((element) => element.activity == data.activites[index])
                  .toList(),
              activity: data.activites[index]),
      (AdventureState.loaded) => AdventuresListView(
          adventures: data.adventureWithActivity[index].adventures
              .where((element) => element.activity == data.activites[index])
              .toList(),
          activity: data.activites[index]),
      (AdventureState.error) => const Center(
          child: Text("An error occurred while fetching data."),
        ),
    };
  }

  @override
  void dispose() {
    super.dispose();
  }
}
