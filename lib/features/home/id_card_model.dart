import 'package:cloud_firestore/cloud_firestore.dart';

class IdCardModel {
  final String id;
  final String imageUrl;
  final String createdAt;



  IdCardModel({
    required this.id,
    required this.imageUrl,
    required this.createdAt,
  });

  // from json to model
  factory IdCardModel.fromJson(Map<String, dynamic> json) {
    return IdCardModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
    );
  }


  // from json to model
  factory IdCardModel.fromFirestore(QueryDocumentSnapshot snapshot) {
    return IdCardModel(
      id: snapshot['id'],
      imageUrl: snapshot['imageUrl'],
      createdAt: snapshot['createdAt'],
    );
  }
}
