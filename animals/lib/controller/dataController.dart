import 'dart:convert';

import 'package:animals/model/animalsModel.dart';
import 'package:animals/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Datacontroller extends ChangeNotifier {
  //SETTER
  List<AnimalsModel>? _model;
  //GETTER
  List<AnimalsModel>? get getModel => _model;

  /// Load JSON from assets and convert to List<AnimalsModel>
  Future<void> loadAnimals() async {
    try {
      ///assets files are read-only...  I might need sharedPref to copi an editable object in app
      ///
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? storedJson = prefs.getString('animalsData');

      if (storedJson != null) {
        // Load from SharedPreferences instead of assets
        List<dynamic> jsonList = json.decode(storedJson);
        _model = AnimalsModel.listOfJsons(jsonList);
      } else {
        // Load from assets only the first time
        String jsonString = await rootBundle.loadString(
          'assets/json/animals.json',
        );
        List<dynamic> jsonList = json.decode(jsonString);
        _model = AnimalsModel.listOfJsons(jsonList);

        // Store the initial data in SharedPreferences
        await prefs.setString('animalsData', jsonString);
      }

      notifyListeners(); // Notify UI once data is loaded
    } catch (e) {
      debugPrint("Error loading JSON: $e"); // Debugging
    }
  }

  //UPDATING MODEL WITH LAST SHARED PREF: VALUE
  Future<void> updateAnimals(List<AnimalsModel> updatedList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(
      updatedList.map((animal) => animal.toJson()).toList(),
    );
    await prefs.setString('animalsData', jsonString);
    _model = updatedList;

    notifyListeners();
  }

  /// Get animals by cattegory
  List<AnimalsModel> getAnimalsByCategory(String category) {
    if (_model == null) return [];

    return _model!.where((animal) => animal.category == category).toList();
  }

    /// Get favourite animals 
  List<AnimalsModel> getFavouriteAnimals() {
    if (_model == null) return [];

    return _model!.where((animal) => animal.favourite == true).toList();
  }

  /// Get specific animal by ID
  AnimalsModel? getAnimalById(int id) {
    return _model?.firstWhere(
      (animal) => animal.id == id,
      orElse: () => AnimalsModel(),
    );
  }

//Generate New ID for the Animal
  int getNextId() {
  return _model != null ? _model!.length + 1 : 1; // ✅ New ID starts at 1 if list is empty
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
        categoryColorMap[animal.category!] =
            animal.color!; // Store first occurrence
      }
    }
    // Convert Map into List of JSON objects
    return categoryColorMap.entries
        .map((entry) => {"category": entry.key, "color": entry.value})
        .toList();
  }

///////////////SAVE
void addNewAnimal(int id, String name, List<int> color, String category, String imagePath) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedJson = prefs.getString('animalsData');
  
  List<AnimalsModel> animals = [];

  if (storedJson != null) {
    List<dynamic> jsonList = json.decode(storedJson);
    animals = AnimalsModel.listOfJsons(jsonList);
  }

  // ✅ Create new animal object
  AnimalsModel newAnimal = AnimalsModel(
    id: id,
    name: name,
    color: color,
    category: category,
    image: imagePath, // ✅ Store image path
    favourite: false, // Default favorite status
  );

  // ✅ Add to list & save in SharedPreferences
  animals.add(newAnimal);
  String updatedJson = json.encode(animals.map((animal) => animal.toJson()).toList());
  await prefs.setString('animalsData', updatedJson);

  _model = animals;
  notifyListeners(); // ✅ Refresh UI if needed
}
  ///////////////////UPDATES
  Future<void> updateFavouriteStatus(int animalId, bool isFavourite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedJson = prefs.getString('animalsData');

    if (storedJson != null) {
      // Decode JSON
      List<dynamic> jsonList = json.decode(storedJson);
      List<AnimalsModel> animals = AnimalsModel.listOfJsons(jsonList);

      // Find the animal by ID and update its favourite status
      for (var animal in animals) {
        if (animal.id == animalId) {
          animal.favourite = isFavourite; // Update the actual list item
          break;
        }
      }

      // Save updated list back to SharedPreferences
      String updatedJson = json.encode(
        animals.map((animal) => animal.toJson()).toList(),
      );
      await prefs.setString('animalsData', updatedJson);

      _model = animals;
      notifyListeners(); // Update UI
    }
  }

    Future<void> updateName(int animalId, String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedJson = prefs.getString('animalsData');

    if (storedJson != null) {
      // Decode JSON
      List<dynamic> jsonList = json.decode(storedJson);
      List<AnimalsModel> animals = AnimalsModel.listOfJsons(jsonList);

      // Find the animal by ID and update its favourite status
      for (var animal in animals) {
        if (animal.id == animalId) {
          animal.name = newName; // Update the actual list item
          break;
        }
      }

      // Save updated list back to SharedPreferences
      String updatedJson = json.encode(
        animals.map((animal) => animal.toJson()).toList(),
      );
      await prefs.setString('animalsData', updatedJson);

      _model = animals;
      notifyListeners(); // Update UI
    }
  }

      Future<void> updateCategoryColor(String category,List<int> newColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedJson = prefs.getString('animalsData');

    if (storedJson != null) {
      // Decode JSON
      List<dynamic> jsonList = json.decode(storedJson);
      List<AnimalsModel> animals = AnimalsModel.listOfJsons(jsonList);

      // Find the animal by ID and update its favourite status
      for (var animal in animals) {
        if(animal.category==category){
          animal.color = newColor; 
          }// Update category color to all amnimals in that ctaegory
      }

      // Save updated list back to SharedPreferences
      String updatedJson = json.encode(
        animals.map((animal) => animal.toJson()).toList(),
      );
      await prefs.setString('animalsData', updatedJson);

      _model = animals;
      notifyListeners(); // Update UI
    }
  }

  //////////DELETES
   Future<void> deleteCategoryAndAnimals(String category, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedJson = prefs.getString('animalsData');

  if (storedJson != null) {
    // Decode JSON
    List<dynamic> jsonList = json.decode(storedJson);
    List<AnimalsModel> animals = AnimalsModel.listOfJsons(jsonList);

    // ✅ Remove all animals from this category
    animals.removeWhere((animal) => animal.category == category);

    // ✅ Save updated list back to SharedPreferences
    String updatedJson = json.encode(
      animals.map((animal) => animal.toJson()).toList(),
    );
    await prefs.setString('animalsData', updatedJson);

    _model = animals;
    notifyListeners(); // ✅ Refresh UI after deletion
  }

  // ✅ Navigate back to Menu.dart
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
}

}
