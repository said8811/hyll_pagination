import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:hyll/main/domain/model/adventure_data.dart';
import 'package:hyll/main/domain/model/hyll_states.dart';
import 'package:hyll/main/presentation/widgets/adventure_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hyll/main/shared/providers.dart';

import '../style/colors.dart';

class AdventurePage extends ConsumerStatefulWidget {
  final String id;
  const AdventurePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<AdventurePage> createState() => _AdventurePageState();
}

class _AdventurePageState extends ConsumerState<AdventurePage> {
  @override
  void initState() {
    ref.read(adventureNotifierProvider.notifier).getSingleData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(adventureNotifierProvider);
    return Scaffold(body: SafeArea(child: _buildAdventure(data)));
  }

  Widget _buildAdventure(AdventureData data) {
    return switch (data.state) {
      (AdventureState.loading) => const Center(
          child: CircularProgressIndicator(),
        ),
      (AdventureState.loaded) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        data.adventure.authorUser!.profilePicture!,
                      ),
                      minRadius: 10,
                      maxRadius: 25,
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.adventure.externalAuthor!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const Gap(10),
                        Text(
                          data.adventure.authorUser!.hyllUsername!,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              AdventureWidget(
                  imageUrl: data.adventure.startingLocation!.imageUrl ?? "",
                  title: data.adventure.title!,
                  primaryDescription: data.adventure.description!,
                  tags: data.adventure.tags!,
                  id: data.adventure.id.toString()),
              const Gap(10),
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white),
                child: ExpansionTile(
                  title: const Text("Tags"),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    Wrap(children: [
                      ...List.generate(
                          data.adventure.tags!.length,
                          (index) => Card(
                                elevation: 2,
                                margin: const EdgeInsets.all(5),
                                child: Text(
                                  "  #${data.adventure.tags![index]}  ",
                                  style: TextStyle(color: AppColors.tagColor),
                                ),
                              ))
                    ]),
                  ],
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white),
                child: ExpansionTile(
                  title: const Text("Facts"),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    ...List.generate(
                        data.adventure.facts!.length,
                        (index) => ExpansionTile(
                              childrenPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              title: Text(data.adventure.facts![index].name!),
                              children: [
                                ListTile(
                                  title: Text(
                                    data.adventure.facts![index].value ??
                                        "No info",
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            )),
                  ],
                ),
              ),
              ListTile(
                title: Text(data.adventure.startingLocation!.name!),
                subtitle: Text(data.adventure.startingLocation!.address!),
                trailing: IconButton(
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse(
                          "https://www.google.com/maps/search/?api=1&query=${data.adventure.startingLocation!.lat},${data.adventure.startingLocation!.lng}"))) {
                        Fluttertoast.showToast(
                            msg: "We can not open address",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.primary,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    icon: const Icon(Icons.location_on)),
              )
            ],
          ),
        ),
      (AdventureState.error) => const Center(
          child: Text("something went wrong"),
        )
    };
  }
}
