import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:id_card_scan/features/home/id_card_model.dart';
import 'package:uuid/uuid.dart';

class HomeService {
  late FirebaseFirestore _firestore;

  HomeService() {
    _firestore = FirebaseFirestore.instance;
  }

  // get id card list stream from firebase
  Stream<List<IdCardModel>>? getIDCards() {
    try {
      final CollectionReference _cardsCollection =
          _firestore.collection('cards');
      return _cardsCollection
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return IdCardModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      return null;
    }
  }

  // upload id card to firebase
  Future<void> uploadIDCard({required Uint8List image}) async {
    final uuid = const Uuid().v4();

    // upload image to firebase storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('cards/$uuid.jpg');
    UploadTask uploadTask = ref.putData(image);
    await uploadTask.then((value) async {
      final CollectionReference _cardsCollection =
          _firestore.collection('cards');
      final imageUrl = await value.ref.getDownloadURL();

      final valueToAdd = {
        'id': uuid,
        'imageUrl': imageUrl,
        'date': DateTime.now().toIso8601String(),
        'createdAt': Timestamp.now(),
      };
      await _cardsCollection
          .add(valueToAdd)
          .then((value) => debugPrint("Card Added"))
          .catchError((error) => debugPrint("Failed to add car: $error"));
    }).catchError((error) {
      throw Exception('Failed to upload image: $error');
    });
  }
}
