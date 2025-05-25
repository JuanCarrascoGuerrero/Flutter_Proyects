import 'dart:io';

import 'package:animals/view/newAnimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  File? _image;
  TextEditingController categoryName = TextEditingController();
  Color selectedColor = const Color.fromARGB(255, 158, 158, 158);
  List<int> newColor = [];

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
        ratioX: 239,
        ratioY: 304,
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
                newColor = [255, color.red, color.green, color.blue];
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

  //ANIMATION TO SAVE
  void _saveCategory(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: MediaQuery.of(context).size.width * 0.3,
            child: _buildSaveAnimation(),
          ),
    );

    // ✅ Add overlay animation
    Overlay.of(context).insert(overlayEntry);

    // ✅ Remove animation after a short delay and navigate to next screen
    Future.delayed(Duration(seconds: 1), () {
      overlayEntry.remove();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewAnimal(categoryName.text, newColor, _image!),
        ),
      );
    });
  }

  // ✅ Animation Widget
  Widget _buildSaveAnimation() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 50), // ✅ Moves higher
      builder: (context, value, child) {
        return Positioned(
          bottom: 60 - value, // ✅ Starts near the button & moves up
          left:
              MediaQuery.of(context).size.width * 0.5 -
              75, // ✅ Center horizontally
          child: Opacity(
            opacity: 1 - (value / 50), // ✅ Fades out gradually
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                "Category saved!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New category", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
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
                          "assets/img/newCategory.png",
                          width: 239,
                          height: 304,
                        ) // Placeholder
                        : Image.file(_image!, width: 239, height: 304),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: categoryName,
                maxLength: 21, // ✅ Limits input to 12 characters
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.bookmark_outline_rounded),
                  hintText: "Category Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _pickColor, // ✅ Same function as before
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedColor, // ✅ Button color dynamically changes
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Colors.white,
                  ), // ✅ Icon inside button
                  SizedBox(width: 8),
                  Text(
                    "Pick a Category Color",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {
                  if (newColor.isEmpty) {
                    newColor = [255, 158, 158, 158];
                  }
                  if (_image == null || !_image!.existsSync() || categoryName=="") {
                    // ✅ If no image, show a warning or prevent save
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please upload an image and a name before saving!"),
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
