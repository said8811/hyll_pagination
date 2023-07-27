import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyll/main/domain/model/hyll_states.dart';
import 'package:hyll/main/infrasturcture/repository/hyll_data_repository.dart';

import '../domain/model/adventure_data.dart';

class ActivityNotifier extends StateNotifier<ActivityData> {
  final HyllDataRepository repository;
  ActivityNotifier({required this.repository})
      : super(ActivityData(activites: [], state: AdventureState.loading));
  getActivities() async {
    final adventureOrFailure = await repository.getActivity();

    state = adventureOrFailure.fold(
      (l) => ActivityData(
        activites: [],
        state: AdventureState.error,
      ),
      (r) => ActivityData(
        activites: r,
        state: AdventureState.loaded,
      ),
    );
  }
}
