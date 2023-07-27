import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyll/main/application/activity_notifier.dart';
import 'package:hyll/main/domain/model/adventure_data.dart';
import '../application/adventure_notifier.dart';
import '../application/state_notifier.dart';
import '../domain/model/hyll_states.dart';
import '../infrasturcture/repository/hyll_data_repository.dart';

final hyllRepositoryProvider = Provider(
  (ref) => HyllDataRepository(dio: Dio()),
);

final adventureNotifierProvider =
    StateNotifierProvider.autoDispose<AdventureNotifier, AdventureData>(
        (ref) => AdventureNotifier(ref.read(hyllRepositoryProvider)));

final hyllNotifierProvider =
    StateNotifierProvider.autoDispose<AdventuresNotifier, HyllData>(
  (ref) => AdventuresNotifier(ref.watch(hyllRepositoryProvider)),
);
final activityNotifierProvider =
    StateNotifierProvider.autoDispose<ActivityNotifier, ActivityData>(
  (ref) => ActivityNotifier(ref.watch(hyllRepositoryProvider)),
);
