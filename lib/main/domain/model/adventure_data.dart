import 'package:hyll/main/domain/model/adventure_model.dart';
import 'package:hyll/main/domain/model/hyll_states.dart';

class AdventureData {
  final AdventureModel adventure;
  final AdventureState state;

  AdventureData({
    required this.adventure,
    required this.state,
  });
}
