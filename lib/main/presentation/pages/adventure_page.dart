import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hyll/main/domain/model/adventure_data.dart';
import 'package:hyll/main/domain/model/hyll_states.dart';
import 'package:hyll/main/presentation/pages/video_player.dart';
import 'package:shimmer/shimmer.dart';
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
  int selectedImage = 0;
  @override
  void initState() {
    ref.read(adventureNotifierProvider.notifier).getSingleData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(adventureNotifierProvider);
    return Scaffold(body: _buildAdventure(data));
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
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        data.adventure.contents![selectedImage].contentUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      padding: const EdgeInsets.all(120),
                      alignment: Alignment.topRight,
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
                        padding: const EdgeInsets.all(120),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Positioned(
                      top: 30,
                      left: 20,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: SvgPicture.asset("assets/svg/back_icon.svg"))),
                  Positioned(
                      top: 30,
                      right: 20,
                      child: IconButton(
                          onPressed: () {},
                          icon: Container(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.favoriteColor,
                            ),
                          ))),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColors.gradientFirst, AppColors.bgColor])),
                height: 100,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Gap(15),
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shrinkWrap: true,
                  itemCount: data.adventure.contents!.length,
                  itemBuilder: (context, index) {
                    final content = data.adventure.contents![index];
                    return CachedNetworkImage(
                      imageUrl: content.contentType == "VIDEO"
                          ? data.adventure.contents![0].contentUrl!
                          : content.contentUrl!,
                      imageBuilder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (content.contentType == "VIDEO") {
                                Get.to(
                                  VideoPLayPage(
                                    videoUrl: content.contentUrl!,
                                  ),
                                );
                              } else {
                                selectedImage = index;
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  data.adventure.contents![index].contentType ==
                                          "VIDEO"
                                      ? data.adventure.contents![0].contentUrl!
                                      : data.adventure.contents![index]
                                          .contentUrl!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child:
                                  data.adventure.contents![index].contentType ==
                                          "VIDEO"
                                      ? const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        )
                                      : const SizedBox(),
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 50,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  },
                ),
              ),
              const Gap(10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Activity",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      data.adventure.activity!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Image.network(
                      data.adventure.activityIcon!,
                      width: 40,
                    ),
                  ],
                ),
              ),
              const Gap(14),
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
                              leading: Image.network(
                                data.adventure.facts![index].iconUrl ??
                                    "https://res.cloudinary.com/hyll/image/upload/v1/media/adventures/icons/slope-uphill_mkva9h_zw6llb",
                                width: 40,
                              ),
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
//  if (data.adventure.contents!
                    //     .any((element) => element.contentType == "VIDEO")) {
                    //   Contents content = data.adventure.contents!.firstWhere(
                    //       (element) => element.contentType == "VIDEO");
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => VideoPLayPage(
                    //           videoUrl: content.contentUrl!,
                    //         ),
                    //       ));
                    // } else {
                    //   Fluttertoast.showToast(
                    //       msg: "This adventure doesn't have video",
                    //       toastLength: Toast.LENGTH_SHORT,
                    //       gravity: ToastGravity.CENTER,
                    //       timeInSecForIosWeb: 1,
                    //       backgroundColor: AppColors.primary,
                    //       textColor: Colors.white,
                    //       fontSize: 16.0);
                    // }