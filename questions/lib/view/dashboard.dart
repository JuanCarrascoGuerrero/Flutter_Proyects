import 'package:flutter/material.dart';
import 'package:questions/view/dropdown/jeedropdown.dart';
import 'package:questions/view/jeeadvanced.dart';
import 'package:questions/view/jeemain.dart';
import 'package:questions/view/mhcet.dart';
import 'package:questions/view/neet.dart';

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
            bottom: 400,
            left: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JeeMain()),
                );
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
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 300,
            left: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Jeeadvanced()),
                );
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
                        "assets/stairs3_2.png",
                        fit: BoxFit.cover, // Ensures image covers its container
                      ),
                    ),
                  ),
                  title: Text('JEE Advanced'),
                  subtitle: Text(
                    "Free questions papers",
                    style: TextStyle(fontSize: 8),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Neet()),
                );
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
                        "assets/net.png",
                        fit: BoxFit.cover, // Ensures image covers its container
                      ),
                    ),
                  ),
                  title: Text('NEET'),
                  subtitle: Text(
                    "Lastest questions papers available",
                    style: TextStyle(fontSize: 8),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mhcet()),
                );
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
                        "assets/tab.png",
                        fit: BoxFit.cover, // Ensures image covers its container
                      ),
                    ),
                  ),
                  title: Text('MH-CET'),
                  subtitle: Text(
                    "Past years papers & solutions",
                    style: TextStyle(fontSize: 8),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Jeedropdown()),
                );
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height / 20,
                width: MediaQuery.sizeOf(context).width / 1.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  //image: DecorationImage(image: AssetImage(assetName))
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Ensures spacing
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ), // Adjust as needed
                      child: Text('dropdown'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
