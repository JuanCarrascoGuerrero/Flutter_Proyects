import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questions/controller/filesapicontrol.dart';
import 'package:questions/view/dropdown/dopdownex.dart';

class Jeedropdown extends StatefulWidget {
  const Jeedropdown({super.key});

  @override
  State<Jeedropdown> createState() => _JeedropdownState();
}

class _JeedropdownState extends State<Jeedropdown> {
  Filesapicontrol c = Get.put(Filesapicontrol());
  bool isExpanded = false; // Track dropdown state

  @override
  void initState() {
    c.category.value = "dropdown";
    c.getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //////////////////////////////////////////////////////////////////BACKGROUND IMAGE
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/jadv.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ////////////////////////////////////////////////////////////////// MENU POP ICON
          Positioned(
            left: 50,
            top: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.menu, size: 60, color: Colors.white),
            ),
          ),
          ///////////////////////////////////////////////////////////////////JEE MAIN TEXT
          Positioned(
            top: 200,
            right: 60,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.orange, Colors.red, Colors.purple],
                ).createShader(bounds);
              },
              child: Text(
                "JEE Advanced",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          //////////////////////////////////////////////////////////////////// UNDERLYING JEE MAIN
          Positioned(
            top: 250,
            right: 0,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [Colors.amber, Colors.deepOrange],
                ).createShader(bounds);
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width / 1.6,
                height: MediaQuery.sizeOf(context).height / 70,
                color: Colors.white,
              ),
            ),
          ),
          ////////////////////////////////////////////////////////////
          Positioned(
            top: 300,
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded; // Toggle dropdown visibility
                      });
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 15,
                      width: MediaQuery.sizeOf(context).width / 1.05,
                      decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          tileColor: Colors.white,
                          title: Text("2018 Question paper", style: TextStyle(fontSize: 20)),
                          trailing: Icon(
                            size: 40,
                            isExpanded
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isExpanded) // Show dropdown content when expanded
                    Column(
                      children: [
                        for (var i in c.getPapersids) Dopdownex(data: i),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
