import '../../domain/model/hyll_model.dart';

List<String> getImageURls(List<Contents> list) {
  List<String> response = [];
  for (var item in list) {
    response.add(item.contentUrl!);
  }
  return response;
}
