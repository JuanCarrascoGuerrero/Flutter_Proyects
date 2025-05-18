import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dopdownex extends StatefulWidget {
  final String data;
  const Dopdownex({required this.data, super.key});

  @override
  State<Dopdownex> createState() => _DopdownexState();
}

class _DopdownexState extends State<Dopdownex> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          height: MediaQuery.sizeOf(context).height / 15,
          width: MediaQuery.sizeOf(context).width / 1.05,
          child: Card(
            color: Colors.white,
            child: Stack(
              clipBehavior: Clip.none, // Allows overflow beyond the card
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.data, style: TextStyle(color: Colors.red, fontSize: 18),),
                    ),
                    Spacer(), // Pushes image to the right
                  ],
                ),
                Positioned(
                  right: -10, // Moves image slightly outside the card
                  top: -5, // Adjust vertical positioning
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          Colors
                              .transparent, // Optional, ensures no background color
                    ),
                    child: Image.asset(
                      "assets/dwno.png",
                      fit:
                          BoxFit
                              .cover, // Ensures the image fills the entire 50x50 space
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Use widget.data
      ],
    );
  }
}
