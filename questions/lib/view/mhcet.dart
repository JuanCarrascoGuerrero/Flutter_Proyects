import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questions/controller/filesapicontrol.dart';

import 'pdfExample.dart';

class Mhcet extends StatefulWidget {
  const Mhcet({super.key});

  @override
  State<Mhcet> createState() => _MhcetState();
}

class _MhcetState extends State<Mhcet> {
  Filesapicontrol c = Get.put(Filesapicontrol());

  @override
  void initState() {
    c.category.value = "mhcet";
    c.getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            c.getModel.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    //////////////////////////////////////////////////////////////////BACKGROUND IMAGE
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/mhcet.png"),
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
                          "MH-CET",
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

                    //////////////////////////////////////////////////////////////////// LIST OF FILES
                    c.getModel.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
                          padding: EdgeInsets.only(
                            top: 280,
                            left: 10,
                            right: 10,
                          ), // Add padding to the edges
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var i in c.getModel) ...[
                                  Card(
                                    color: Colors.white,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        10,
                                      ), // Add padding inside the Card
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start, // Align items at the top
                                        children: [
                                          Expanded(
                                            child: Text(
                                              i.year!,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ), // Space between the image and text
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                      title: Text(
                                                        "Would you like to download ${i.file!.substring(i.file!.length - 8)} ?",
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (
                                                                      context,
                                                                    ) => PdfViewExample(
                                                                      url:
                                                                          i.file!,
                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          child: Text("Yes"),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Text("No"),
                                                        ),
                                                      ],
                                                    ),
                                              );
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/dwnb.png",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
      ),
    );
  }
}
