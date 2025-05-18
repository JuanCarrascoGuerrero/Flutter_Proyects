import 'package:flutter/material.dart';
import 'package:questions/view/jeemain.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 300,
            left: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>JeeMain()));
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height / 10,
                width: MediaQuery.sizeOf(context).width / 1.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  //image: DecorationImage(image: AssetImage(assetName))
                ),
                child: ListTile(
                  leading: Container(
                    width: MediaQuery.sizeOf(context).width / 10,
                    height: MediaQuery.sizeOf(context).height / 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:
                          Colors
                              .transparent, // Optional: Transparent color for better visuals
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Ensures circular edges
                      child: Image.asset(
                        "assets/stairs.png",
                        fit: BoxFit.cover, // Ensures image covers its container
                      ),
                    ),
                  ),
                  title: Text('JEE Mains'),
                  subtitle: Text(
                    "Original questions, papers & answers",
                    style: TextStyle(fontSize: 8),
                  ),
                  trailing: Icon(Icons.arrow_forward)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
