import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyll/main/domain/model/hyll_model.dart';
import 'package:hyll/main/infrasturcture/repository/hyll_data_repository.dart';

import '../domain/model/hyll_states.dart';

class AdventuresNotifier extends StateNotifier<HyllData> {
  HyllDataRepository repository;
  AdventuresNotifier(this.repository)
      : super(HyllData(
            adventures: [], nextPageUrl: null, state: AdventureState.loading)) {
    fetchData("https://api.hyll.com/api/adventures");
  }
  fetchData(String url) async {
    state = HyllData(
      adventures: state.adventures,
      nextPageUrl: state.nextPageUrl,
      state: AdventureState.loading,
    );
    final response = await repository.getData(url);

    state = response.fold(
        (l) => HyllData(
            adventures: state.adventures,
            nextPageUrl: state.nextPageUrl,
            state: AdventureState.error),
        (r) => HyllData(
            adventures: [...state.adventures, ...r.data!],
            nextPageUrl: r.next,
            state: AdventureState.loaded));
  }

  Future<void> fetchNextPage() async {
    try {
      final HyllDataModel? newData = await fetchData(state.nextPageUrl ??
          "https://api.hyll.com/api/adventures/?limit=20&offset=10");
      state = HyllData(
        adventures: state.adventures,
        nextPageUrl: state.nextPageUrl,
        state: AdventureState.loading,
      );
      if (newData != null) {
        List<Data> adventures = state.adventures;

        adventures.addAll(newData.data!);
        state = HyllData(
          adventures: adventures,
          nextPageUrl: newData.next,
          state: AdventureState.loaded,
        );
      } else {
        state = HyllData(
          adventures: state.adventures,
          nextPageUrl: state.nextPageUrl,
          state: AdventureState.loaded,
        );
      }
    } catch (error) {
      state = HyllData(
        adventures: state.adventures,
        nextPageUrl: state.nextPageUrl,
        state: AdventureState.error,
      );
    }
  }
}
