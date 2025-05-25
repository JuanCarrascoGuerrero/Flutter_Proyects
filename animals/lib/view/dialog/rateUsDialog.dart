import 'package:flutter/material.dart';

class RateUsDialog extends StatefulWidget {
  @override
  _RateUsDialogState createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ HEADER WITH CLOSE BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rate Us!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(), // ✅ Closes dialog
                ),
              ],
            ),

            // ✅ STAR RATING SYSTEM
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border, // ✅ Highlights previous stars
                    color: Colors.yellow,
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1; // ✅ Fills stars progressively
                    });
                  },
                );
              }),
            ),

            // ✅ RATE US IMAGE
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.asset("assets/img/rateUs.png"),
            ),

            // ✅ SUBMIT BUTTON
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // ✅ Close after submitting
                // ✅ You can add a function to save the rating here!
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
