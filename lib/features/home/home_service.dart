import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:id_card_scan/features/home/id_card_model.dart';

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
}
