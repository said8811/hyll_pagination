import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hyll/main/presentation/widgets/adventure_widget.dart';
import 'package:hyll/main/presentation/widgets/loading_widget.dart';
import 'package:hyll/main/shared/providers.dart';

import '../../domain/model/hyll_states.dart';
import 'adventure_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScrollController scrollController = ScrollController();

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
        centerTitle: true,
        title: const Text(
          "Hyll",
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Gap(10),
        shrinkWrap: true,
        controller: scrollController,
        itemCount: _itemsCount(adventureData),
        itemBuilder: (context, index) {
          return _buildList(adventureData, index);
        },
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
                imageUrl: data.adventures[index].contents![0].contentUrl ?? "",
                title: data.adventures[index].title ?? "UnNamed",
                primaryDescription:
                    data.adventures[index].primaryDescription ?? "",
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
            imageUrl: data.adventures[index].contents![0].contentUrl ?? "",
            title: data.adventures[index].title ?? "UnNamed",
            primaryDescription: data.adventures[index].primaryDescription ?? "",
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
