import 'dart:convert';
import 'dart:io';

import 'package:animals/model/animalsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Datacontroller extends ChangeNotifier {
//SETTER
List<AnimalsModel>? _model;
//GETTER
List<AnimalsModel>? get getModel => _model;

  /// Load JSON from assets and convert to List<AnimalsModel>
  Future<void> loadAnimals() async {
    try {
      // Load JSON file from assets
      String jsonString = await rootBundle.loadString('assets/json/animals.json');

      // Decode JSON directly as a List instead of a Map
      List<dynamic> jsonList = json.decode(jsonString);

      // Convert JSON list into List<AnimalsModel>
      _model = AnimalsModel.listOfJsons(jsonList);

      notifyListeners(); // Notify UI once data is loaded
      
    } catch (e) {
      debugPrint("Error loading JSON: $e"); // Debugging
    }
  }

/// Get animals by cattegory
List<AnimalsModel> getAnimalsByCategory(String category) {
  if (_model == null) return [];

   return _model!.where((animal) => animal.category == category).toList();
}

  /// Get specific animal by ID
  AnimalsModel? getAnimalById(int id) {
    return _model?.firstWhere((animal) => animal.id == id, orElse: () => AnimalsModel());
  }

 /// Get disctinct categories
  List<String?> findCategories() {
  if (_model == null) return [];
  return _model!.map((animal) => animal.category).toSet().toList();
}

 /// Get disctinct categories with color associated
List<Map<String, dynamic>> findCategoriesWithColors() {
  if (_model == null) return [];
  Map<String, List<int>> categoryColorMap = {};
  for (var animal in _model!) {
    if (!categoryColorMap.containsKey(animal.category)) {
      categoryColorMap[animal.category!] = animal.color!; // Store first occurrence
    }
  }
    // Convert Map into List of JSON objects
  return categoryColorMap.entries.map((entry) => { "category": entry.key,"color": entry.value}).toList();
}


///////////////////UPDATES

}