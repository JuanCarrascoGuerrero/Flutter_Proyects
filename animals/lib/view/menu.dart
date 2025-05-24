import 'package:animals/controller/dataController.dart';
import 'package:animals/view/dashboard.dart';
import 'package:animals/view/ppd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    context.read<Datacontroller>().loadAnimals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/img/background.png",
                fit: BoxFit.cover, // Ensures the image covers the drawer
              ),
            ),
            Column(
              children: [
                DrawerHeader(
                  child: Image.asset("assets/img/logo.png"),
                  decoration: null,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 17.0, left: 17.0),
                  child: Column(
                    children: [
                      Card( // Adds slight shadow effect
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        color: const Color.fromARGB(255, 150, 100, 81), // Change to your desired color
                        child: ListTile(
                          onTap: () {},
                          leading: Icon(Icons.favorite_border_rounded,color: Colors.white,),
                          title: Text("Favourites",style: TextStyle(color: Colors.white),),
                          trailing: Icon(Icons.arrow_forward_outlined,color: Colors.white,),
                        ),
                      ),
                      Card( // Adds slight shadow effect
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        color: const Color.fromARGB(255, 150, 100, 81), // Change to your desired color
                        child: ListTile(
                          onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Menu()));},
                          leading: Icon(Icons.bookmark_outline_rounded,color: Colors.white,),
                          title: Text("Categories",style: TextStyle(color: Colors.white),),
                          trailing: Icon(Icons.arrow_forward_outlined,color: Colors.white,),
                        ),
                      ),
                      Card( // Adds slight shadow effect
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        color: const Color.fromARGB(255, 150, 100, 81), // Change to your desired color
                        child: ListTile(
                          onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard("")));},
                          leading: Icon(Icons.cruelty_free_rounded,color: Colors.white,),
                          title: Text("All Animals",style: TextStyle(color: Colors.white),),
                          trailing: Icon(Icons.arrow_forward_outlined,color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.only(right: 17.0, left: 17.0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.hotel_class_rounded,color: Colors.brown,),
                        title: Text("Rate Us",style: TextStyle(color: Colors.black),),
                      ),
                      ListTile(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Ppd()));},
                        leading: Icon(Icons.fact_check_rounded,color: Colors.brown,),
                        title: Text("Terms & Conditions",style: TextStyle(color: Colors.black),),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.diversity_1_rounded,color: Colors.brown,),
                        title: Text("Share App",style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body:
          context.watch<Datacontroller>().getModel == null
              ? Center(child: CircularProgressIndicator())
              : GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10
                ),
                children: [
                  Image.asset("assets/animals/all_animals.png"),
                  for (var i
                      in context.watch<Datacontroller>().findCategoriesWithColors()) ...[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(i["category"])));
                          },
                          child: Image.asset(
                            "assets/animals/" + i["category"].toLowerCase().replaceAll(" ", "_") + ".png",
                                      width: 150, height: 550, fit: BoxFit.cover,),
                        ),                     
                        Positioned(// Overlay Rectangle at Bottom
                            bottom: 0, // Positions it at the bottom of the image
                            left: 25,right: 25,
                            child: Container(
                              alignment: Alignment.center,
                                    height: 50,width: 150, // Adjust height for 20% coverage
                                    color: Color.fromARGB(
                                            i["color"][0],  // Access first color value
                                              i["color"][1],  // Access second color value
                                              i["color"][2],  // Access third color value
                                              i["color"][3], ), // Semi-transparent background
                                    child: Center(
                                          child: Text(i["category"], // Category name 
                                                  style: TextStyle(color: Colors.white, fontSize: 14),),
                                                ),
                                              ),
                                    ),
                      ],
                    ),
                  ],
                  Image.asset("assets/animals/add.png"),
                ],
              ),
    );
  }
}
