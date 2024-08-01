import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

      return _cardsCollection.snapshots().map((snapshot) {
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
    try {
      final uuid = const Uuid().v4();

      // upload image to firebase storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('cards/$uuid.jpg');
      UploadTask uploadTask = ref.putData(image);
      await uploadTask.whenComplete(() async {
        final CollectionReference _cardsCollection =
            _firestore.collection('cards');
        await _cardsCollection.add({
          'id': uuid,
          'image': image,
          'createdAt': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      throw e;
    }
  }
}
