import 'package:animals/controller/dataController.dart';
import 'package:animals/controller/triangleClipper.dart';
import 'package:animals/view/detailAnimal.dart';
import 'package:animals/view/menu.dart';
import 'package:animals/view/ppd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final String category; //Passed string on call to class
  const Dashboard(this.category, {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

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
              : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      for (var i
                          in widget.category==""? context.watch<Datacontroller>().getModel ?? []
                          : context.watch<Datacontroller>().getAnimalsByCategory(widget.category)) ...[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailAnimal(i)));},  //"Acces to detail with ringtone, etc..."
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/animals/" + i.image!,
                                ), // Use your image path
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: ClipPath(
                                    clipper: TriangleClipper(),
                                    child: Container(
                                      width: 230, // Increase width
                                      height: 80, // Increase height
                                      color: Color.fromARGB(
                                        i.color?[0] ?? 255, // Default to 255 if null
                                        i.color?[1] ?? 0, // Default to 0 if null
                                        i.color?[2] ?? 0, // Default to 0 if null
                                        i.color?[3] ?? 255, // Default to 255 if null
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        i.name!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
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
    );
  }
}
