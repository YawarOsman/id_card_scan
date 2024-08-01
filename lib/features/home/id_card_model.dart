class IdCardModel {
  final String id;
  final String imageUrl;
  final String date;

  IdCardModel({
    required this.id,
    required this.imageUrl,
    required this.date,
  });

  // from json to model
  factory IdCardModel.fromJson(Map<String, dynamic> json) {
    return IdCardModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      date: json['date'],
    );
  }
}
