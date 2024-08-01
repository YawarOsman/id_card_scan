import 'dart:typed_data';

import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  Uint8List? _selectedImage;
   
  Uint8List? get selectedImage => _selectedImage;

  void setSelectedImage(Uint8List? image){
    _selectedImage = image;
    notifyListeners();
  }
}