import 'package:hyll/main/domain/model/hyll_model.dart';

enum AdventureState {
  loading,
  loaded,
  error,
}

class AdventureWithActivity {
  final List<Data> adventures;
  final String activity;

  AdventureWithActivity({
    required this.adventures,
    required this.activity,
  });
}

class HyllData {
  final List<AdventureWithActivity> adventureWithActivity;
  final List<String> activites;

  final String? nextPageUrl;
  final AdventureState state;

  HyllData({
    required this.adventureWithActivity,
    required this.activites,
    required this.nextPageUrl,
    required this.state,
  });
}
