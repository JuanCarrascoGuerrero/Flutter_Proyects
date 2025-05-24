import 'package:animals/controller/dataController.dart';
import 'package:animals/model/animalsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailAnimal extends StatefulWidget {
  final AnimalsModel animal;

  const DetailAnimal(this.animal, {super.key});

  @override
  State<DetailAnimal> createState() => _DetailAnimalState();
}

class _DetailAnimalState extends State<DetailAnimal> {
  late bool isLiked;

    @override
  void initState() {
    super.initState();
    isLiked = widget.animal.favourite ?? false; // Safely initialize inside initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ), // Adds side padding
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceEvenly, // Evenly distributes icons & text
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  widget.animal.name!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.phonelink_ring_rounded),
              ],
            ),
          ),
          Stack(
            children: [
              Image.asset("assets/img/circle.png"),
              Positioned(
                top: 70, // Adjust positioning
                left: 100,
                child: ClipOval(
                  child: Image.asset(
                    "assets/animals/" +
                        widget.animal.image!, // Replace with actual route
                    width: 220, // Adjust size
                    height: 220,
                    fit: BoxFit.cover, // Ensures image fills the circular shape
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isLiked = !isLiked; // Toggle like status
                  // Update the Datacontroller and persist the change?¿?
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // Smooth transition
              curve: Curves.easeOut,
              transform:
                  Matrix4.identity()
                    ..scale(isLiked ? 1.3 : 1.0), // Scale effect
              child: Icon(
                isLiked
                    ? Icons.favorite
                    : Icons.favorite_outline_rounded, // Change icon
                color: isLiked ? Colors.red : Colors.grey, // Change color
                size: isLiked ? 36 : 30, // Increase size when liked
              ),
            ),
          ),
        ],
      ),
    );
  }
}
