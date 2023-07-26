class ActivityModel {
  int id;
  String name;
  String? image;
  String? previewImage;
  int? position;

  ActivityModel(
      {required this.id,
      required this.name,
      this.image,
      this.previewImage,
      this.position});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      position: json['position'],
    );
  }
}
