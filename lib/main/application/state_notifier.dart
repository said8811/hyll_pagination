import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyll/main/domain/model/hyll_model.dart';
import 'package:hyll/main/infrasturcture/repository/hyll_data_repository.dart';

import '../domain/model/hyll_states.dart';

class AdventuresNotifier extends StateNotifier<HyllData> {
  HyllDataRepository repository;
  AdventuresNotifier(this.repository)
      : super(HyllData(
            activites: [],
            adventureWithActivity: [],
            nextPageUrl: null,
            state: AdventureState.loading)) {
    fetchData("https://api.hyll.com/api/adventures");
  }
  List<String> activity = [];

  fetchData(String url) async {
    state = HyllData(
      activites: state.activites,
      adventureWithActivity: state.adventureWithActivity,
      nextPageUrl: state.nextPageUrl,
      state: AdventureState.loading,
    );
    final response = await repository.getData(url);

    state = response.fold(
        (l) => HyllData(
            activites: state.activites,
            adventureWithActivity: state.adventureWithActivity,
            nextPageUrl: state.nextPageUrl,
            state: AdventureState.error), (r) {
      for (var a in r.data!) {
        if (!activity.contains(a.activity)) {
          activity.add(a.activity!);
          final AdventureWithActivity adventureWithActivity =
              AdventureWithActivity(
                  adventures: r.data!
                      .where((element) => element.activity == a.activity)
                      .toList(),
                  activity: a.activity!);
          state.adventureWithActivity.add(adventureWithActivity);
        }
      }
      return HyllData(
          activites: activity,
          adventureWithActivity: state.adventureWithActivity,
          nextPageUrl: r.next,
          state: AdventureState.loaded);
    });
  }

  Future<void> fetchNextPage() async {
    try {
      final HyllDataModel? newData = await fetchData(state.nextPageUrl!);
      state = HyllData(
        activites: activity,
        adventureWithActivity: state.adventureWithActivity,
        nextPageUrl: state.nextPageUrl,
        state: AdventureState.loading,
      );
      if (newData != null) {
        final adventures = state.adventureWithActivity;
        for (var a in newData.data!) {
          final advenAndActivity = AdventureWithActivity(
              adventures: newData.data!
                  .where((element) => element.activity == a.activity)
                  .toList(),
              activity: a.activity!);
          adventures.add(advenAndActivity);
        }
        state = HyllData(
          activites: [],
          adventureWithActivity: adventures,
          nextPageUrl: newData.next,
          state: AdventureState.loaded,
        );
      } else {
        state = HyllData(
          activites: state.activites,
          adventureWithActivity: state.adventureWithActivity,
          nextPageUrl: state.nextPageUrl,
          state: AdventureState.loaded,
        );
      }
    } catch (error) {
      state = HyllData(
        activites: state.activites,
        adventureWithActivity: state.adventureWithActivity,
        nextPageUrl: state.nextPageUrl,
        state: AdventureState.error,
      );
    }
  }
}
