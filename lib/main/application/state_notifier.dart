import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyll/main/domain/model/hyll_model.dart';
import 'package:hyll/main/infrasturcture/repository/hyll_data_repository.dart';

import '../domain/model/hyll_states.dart';

class AdventuresNotifier extends StateNotifier<HyllData> {
  HyllDataRepository repository;
  AdventuresNotifier(this.repository)
      : super(HyllData(
            activites: [],
            adventures: [],
            nextPageUrl: null,
            state: AdventureState.loading)) {
    fetchData("https://api.hyll.com/api/adventures");
  }
  List<String> activity = ["All"];

  fetchData(String url) async {
    state = HyllData(
      activites: state.activites,
      adventures: state.adventures,
      nextPageUrl: state.nextPageUrl,
      state: AdventureState.loading,
    );
    final response = await repository.getData(url);

    state = response.fold(
        (l) => HyllData(
            activites: state.activites,
            adventures: state.adventures,
            nextPageUrl: state.nextPageUrl,
            state: AdventureState.error), (r) {
      for (var a in r.data!) {
        if (!activity.contains(a.activity)) {
          activity.add(a.activity!);
        }
      }
      r.data!.sort((a, b) => a.activity!.compareTo(b.activity!));
      return HyllData(
          activites: activity,
          adventures: [
            ...state.adventures,
            ...r.data!,
          ],
          nextPageUrl: r.next,
          state: AdventureState.loaded);
    });
  }

  Future<void> fetchNextPage() async {
    try {
      final HyllDataModel? newData = await fetchData(state.nextPageUrl!);
      state = HyllData(
        activites: activity,
        adventures: state.adventures,
        nextPageUrl: state.nextPageUrl,
        state: AdventureState.loading,
      );
      if (newData != null) {
        List<Data> adventures = state.adventures;

        adventures.addAll(newData.data!);
        state = HyllData(
          activites: [],
          adventures: adventures,
          nextPageUrl: newData.next,
          state: AdventureState.loaded,
        );
      } else {
        state = HyllData(
          activites: state.activites,
          adventures: state.adventures,
          nextPageUrl: state.nextPageUrl,
          state: AdventureState.loaded,
        );
      }
    } catch (error) {
      state = HyllData(
        activites: state.activites,
        adventures: state.adventures,
        nextPageUrl: state.nextPageUrl,
        state: AdventureState.error,
      );
    }
  }
}
