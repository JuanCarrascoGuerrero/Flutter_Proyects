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
  late bool isEditing = false;
  late TextEditingController _controller;

    @override
  void initState() {
    super.initState();
    isLiked = widget.animal.favourite ?? false; // Safely initialize inside initState
    _controller = TextEditingController(text: widget.animal.name ?? ""); //Ensure initialization
  }

    Widget buildImage(String category) {
    //// We cannot read in assets so this is manual toggle to avoid running errors
    List<String> existInAssets = [
  "pelican.png", "alpaca.png", "chick.png", "cock.png", "cow.png", "duck.png",
  "goat.png", "sheep.png", "turkey.png", "zebu.png", "bee.png", "grasshopper.png",
  "mosquito.png", "wasp.png", "bull.png", "rabbit.png", "elephant.png", "gorilla.png",
  "mouse.png", "cat.png", "dog.png", "guinea.png", "chameleon.png", "crocodile.png",
  "frog.png", "snake.png", "dolphin.png", "seal.png", "hart.png", "hippo.png",
  "penguin.png", "toucan.png"
];
    String formattedCategory = category.toLowerCase().replaceAll(" ", "_");
    String imagePath = "assets/animals/$formattedCategory";

    if (existInAssets.contains(category)) {
      return Image.asset(imagePath, width: 220, height: 220, fit: BoxFit.cover);
    } else {
      return Image.asset(
        "assets/img/newAnimal.png", // ✅ Fallback image if original is missing
        width: 220,
        height: 220,
        fit: BoxFit.cover,
      );
    }
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
                /// **👀 Toggle between Text and TextField**
                isEditing
                    ? Expanded(
                        child: TextField(
                          controller: _controller,
                          autofocus: true, // ✅ Ensures keyboard opens immediately
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done, // ✅ Shows "Done" button on keyboard
                          onSubmitted: (newName) {
                            setState(() {
                              widget.animal.name = newName; // Update model
                              Provider.of<Datacontroller>(context, listen: false).updateName(widget.animal.id!,newName);
                              isEditing = false; // Exit edit mode
                            });
                          },
                        ),
                      )
                    : Text(
                        widget.animal.name!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                Row(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                      isEditing = !isEditing; // Toggle edit mode
                    });
                    },
                    child: Icon(Icons.edit_square)),
                
                
                SizedBox(width: 9,) ,Icon(Icons.phonelink_ring_rounded)],) 
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
                  child: buildImage(widget.animal.image!),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isLiked = !isLiked; // Toggle like status
                // ONLY IN BUILD!!! -> context.watch<Datacontroller>().updateFavouriteStatus(widget.animal.id!, isLiked);
                  // Update the Datacontroller and persist the change?¿?
                Provider.of<Datacontroller>(context, listen: false).updateFavouriteStatus(widget.animal.id!, isLiked);

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
