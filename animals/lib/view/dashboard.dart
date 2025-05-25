import 'dart:io';

import 'package:animals/controller/dataController.dart';
import 'package:animals/controller/triangleClipper.dart';
import 'package:animals/view/detailAnimal.dart';
import 'package:animals/view/favourites.dart';
import 'package:animals/view/menu.dart';
import 'package:animals/view/newAnimal.dart';
import 'package:animals/view/ppd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final String category; //Passed string on call to class
  const Dashboard(this.category, {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Color selectedColor = Colors.grey;

  @override
  void initState() {
    context.read<Datacontroller>().loadAnimals();

    if (widget.category != "") {
      // ✅ Get the color for the selected category
      final categoryColors =
          context.read<Datacontroller>().findCategoriesWithColors();

      final matchedCategory = categoryColors.firstWhere(
        (entry) => entry["category"] == widget.category,
      );

      // ✅ Convert List<int> to Color object
      selectedColor = Color.fromARGB(
        matchedCategory["color"][0],
        matchedCategory["color"][1],
        matchedCategory["color"][2],
        matchedCategory["color"][3],
      );
    }

    super.initState();
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick a Color"),
          content: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
                // ✅ Convert Color object to List<int> (RGB values)
                List<int> newColor = [255, color.red, color.green, color.blue];
                Provider.of<Datacontroller>(
                  context,
                  listen: false,
                ).updateCategoryColor(widget.category, newColor);
              });
            },
          ),
          actions: [
            ElevatedButton(
              child: Text("Select"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete this category and all stored animals?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // ✅ Closes dialog without deleting
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              context.read<Datacontroller>().deleteCategoryAndAnimals(widget.category,context); // ✅ Calls deletion function
              Navigator.pop(context); // ✅ Closes dialog after deletion
            },
            child: Text("Yes", style: TextStyle(color: Colors.red)), // ✅ Highlights danger action
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/img/background.png",
                fit: BoxFit.cover, // Ensures the image covers the drawer
              ),
            ),
            Column(
              children: [
                DrawerHeader(
                  child: Image.asset("assets/img/logo.png"),
                  decoration: null,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 17.0, left: 17.0),
                  child: Column(
                    children: [
                      Card(
                        // Adds slight shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: const Color.fromARGB(
                          255,
                          150,
                          100,
                          81,
                        ), // Change to your desired color
                        child: ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Favourites(),
                              ),
                            );
                          },
                          leading: Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Favourites",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Card(
                        // Adds slight shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: const Color.fromARGB(
                          255,
                          150,
                          100,
                          81,
                        ), // Change to your desired color
                        child: ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Menu()),
                            );
                          },
                          leading: Icon(
                            Icons.bookmark_outline_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Categories",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Card(
                        // Adds slight shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: const Color.fromARGB(
                          255,
                          150,
                          100,
                          81,
                        ), // Change to your desired color
                        child: ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(""),
                              ),
                            );
                          },
                          leading: Icon(
                            Icons.cruelty_free_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "All Animals",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(right: 17.0, left: 17.0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.hotel_class_rounded,
                          color: Colors.brown,
                        ),
                        title: Text(
                          "Rate Us",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ppd()),
                          );
                        },
                        leading: Icon(
                          Icons.fact_check_rounded,
                          color: Colors.brown,
                        ),
                        title: Text(
                          "Terms & Conditions",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.diversity_1_rounded,
                          color: Colors.brown,
                        ),
                        title: Text(
                          "Share App",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body:
          context.watch<Datacontroller>().getModel == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          widget.category == ""
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "All Animals",
                                    style: TextStyle(fontSize: 50),
                                  ),
                                ),
                              )
                              : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.category,
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => showDeleteDialog(context), // ✅ Opens dialog on tap
                                      child: Icon(Icons.delete_forever,color: Colors.red,)),
                                  ],
                                ),
                              ),
                          for (var i
                              in widget.category == ""
                                  ? context.watch<Datacontroller>().getModel ??
                                      []
                                  : context
                                      .watch<Datacontroller>()
                                      .getAnimalsByCategory(
                                        widget.category,
                                      )) ...[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailAnimal(i),
                                    ),
                                  );
                                }, //"Acces to detail with ringtone, etc..."
                                child: Stack(
                                  children: [
                                    i.id! <= 32
                                        ? Image.asset(
                                          "assets/animals/" + i.image!,
                                        )
                                        : Image.asset(
                                          "assets/img/newAnimal.png",
                                        ), // Use your image path
                                    /*Positioned(
                                      top:5, left: 5,
                                      child: Icon(Icons.edit_square,color: Colors.white,)),*/
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: ClipPath(
                                        clipper: TriangleClipper(),
                                        child: Container(
                                          width: 230, // Increase width
                                          height: 80, // Increase height
                                          color: Color.fromARGB(
                                            i.color?[0] ??
                                                255, // Default to 255 if null
                                            i.color?[1] ??
                                                0, // Default to 0 if null
                                            i.color?[2] ??
                                                0, // Default to 0 if null
                                            i.color?[3] ??
                                                255, // Default to 255 if null
                                          ),
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            i.name!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: GestureDetector(
                              onTap: () {
                                List<int> colorList = [255, selectedColor.red, selectedColor.green, selectedColor.blue]; // ✅ Convert Color to List<int>
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewAnimal(widget.category, colorList, File("assets/img/newCategory.png"))));
                              },
                              child: Image.asset(
                                              "assets/img/new.png",
                                            ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 150),
                      Text("© 2025 Animals App. All rights reserved."),
                    ],
                  ),
                ),
              ),

      floatingActionButton:
          widget.category == ""
              ? null
              : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: "pickColorButton",
                    onPressed: _pickColor,
                    tooltip: "Pick a Color",
                    backgroundColor: selectedColor,
                    child: Icon(Icons.color_lens),
                  ),
                ],
              ),
    );
  }
}
