import 'dart:io';

import 'package:animals/controller/dataController.dart';
import 'package:animals/view/successTransaction.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewAnimal extends StatefulWidget {
  final String categoryName;
  final List<int> color;
  final File fileImage;
  const NewAnimal(this.categoryName,this.color,this.fileImage,{super.key});

  @override
  State<NewAnimal> createState() => _NewAnimalState();
}

class _NewAnimalState extends State<NewAnimal> {
  File? _image;
  TextEditingController animalName = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // ✅ Crop Image if it's larger than 239x304
      _cropImage(imageFile);
    }
  }

  //NEEEDS DECLARE ACTIVITY IN THE MANIFEST!!!
  Future<void> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(
        ratioX: 591,
        ratioY: 212,
      ), // ✅ Set exact aspect ratio
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.brown,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true, // ✅ Force the exact dimensions
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path); // ✅ Save final cropped image
      });
    }
  }

void _saveCategory(BuildContext context) async {
  // ✅ Ensure values are correctly formatted
  int newId = context.read<Datacontroller>().getNextId();
  String imageName = "${animalName.text.toLowerCase().replaceAll(" ", "_")}.png";
  String imagePath = "assets/animals/$imageName";

  // ✅ Call controller method, passing all required parameters
  context.read<Datacontroller>().addNewAnimal(
    newId,
    animalName.text, // Name from TextField
    widget.color,    // Passed color
    widget.categoryName, // Category name
    imagePath,       // Image path
  );

  // ✅ Navigate to SuccessTransaction screen
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessTransaction()));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New animal", style: TextStyle(color: Colors.white),),backgroundColor: Colors.brown,),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: _pickImage,
                child:
                    _image == null
                        ? Image.asset(
                          "assets/img/newAnimal.png",
                          width: 591,
                          height: 212,
                        ) // Placeholder
                        : Image.file(_image!, width: 239, height: 304),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: animalName,
                maxLength: 21, // ✅ Limits input to 12 characters
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.bookmark_outline_rounded),
                  hintText: "Animal Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {
                   if (animalName=="") {
                    // ✅ If no image, show a warning or prevent save
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please upload a name before saving!"),
                      ),
                    );
                    return; // ✅ Stop execution if image is missing
                  }
                  _saveCategory(context);
                },
                child: Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}