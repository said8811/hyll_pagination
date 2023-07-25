import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyll/main/domain/model/adventure_data.dart';
import 'package:hyll/main/domain/model/hyll_states.dart';
import 'package:hyll/main/infrasturcture/repository/hyll_data_repository.dart';

import '../domain/model/adventure_model.dart';

class AdventureNotifier extends StateNotifier<AdventureData> {
  final HyllDataRepository repository;
  AdventureNotifier(this.repository)
      : super(AdventureData(
            adventure: AdventureModel(), state: AdventureState.loading));

  getSingleData(String id) async {
    final adventureOrFailure = await repository.getSingleData(id);

    state = adventureOrFailure.fold(
      (l) => AdventureData(
        adventure: AdventureModel(),
        state: AdventureState.error,
      ),
      (r) => AdventureData(
        adventure: r,
        state: AdventureState.loaded,
      ),
    );
  }
}
