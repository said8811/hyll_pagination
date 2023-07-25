import 'package:hyll/main/domain/model/hyll_model.dart';

enum AdventureState {
  loading,
  loaded,
  error,
}

class HyllData {
  final List<Data> adventures;
  final String? nextPageUrl;
  final AdventureState state;

  HyllData({
    required this.adventures,
    required this.nextPageUrl,
    required this.state,
  });
}
