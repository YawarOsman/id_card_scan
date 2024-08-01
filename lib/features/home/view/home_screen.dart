import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_card_scan/features/home/id_card_model.dart';
import 'package:id_card_scan/utility/date_formter.dart';
import 'package:uuid/uuid.dart';

import '../home_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _cardsCollection =
      FirebaseFirestore.instance.collection('cards');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cards')),
      body: StreamBuilder<List<IdCardModel>>(
        stream: HomeService().getIDCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text("You don't have any cards yet"));
          }

          final list = snapshot.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.createdAt.customFormat),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: data.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //  context.push(Routes.upload);
        _addData();
      },
      child: const Icon(Icons.add),
    );
  }

  final uuid = const Uuid().v4();
  void _addData() async {
    await _cardsCollection.add({
      'id': uuid,
      'createdAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKffPiIFHuzrbgSD1F871ubB7P2ngB0-magw&s',
    });
  }
}
