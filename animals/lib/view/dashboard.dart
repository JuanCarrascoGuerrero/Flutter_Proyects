import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
    Color selectedColor = Colors.green;
  String imageLabel = "Bull";

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick a Color"),
          content: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() => selectedColor = color);
            },
          ),
          actions: [
            ElevatedButton(
              child: Text("Select"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset("assets/img/puppies.png", width: 300, height: 300), // Use your image path
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                color: selectedColor,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  imageLabel,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _pickColor,
            tooltip: "Pick a Color",
            backgroundColor: selectedColor,
            child: Icon(Icons.color_lens),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Enter Name"),
                  content: TextField(
                    onChanged: (text) => setState(() => imageLabel = text),
                  ),
                  actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Done"))],
                ),
              );
            },
            tooltip: "Edit Name",
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}