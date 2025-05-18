import 'package:animals/view/ppd.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  PageController controller = PageController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/demo1.png"),
                SizedBox(height: 10),
                Text("Fun Sounds!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Welcome to our animal sound app & get ready to experience fun animal & unique animal sounds"
                      , style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                      textAlign: TextAlign.center,),
                ),
                GestureDetector(
                  onTap: (){
                    controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                  },
                  child: Image.asset("assets/img/paw_green.png",
                  width: MediaQuery.sizeOf(context).width/10,
                  height: MediaQuery.sizeOf(context).height/10,),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/demo2.png"),
                SizedBox(height: 10),
                Text("Set as Ringtone", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Personalize your ringtone with interesting animal sounds & let the symphony begin!"
                      , style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                      textAlign: TextAlign.center,),
                ),
                GestureDetector(
                  onTap: () {
                    controller.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                  },
                  child: Image.asset("assets/img/paw_yellow.png",
                  width: MediaQuery.sizeOf(context).width/10,
                  height: MediaQuery.sizeOf(context).height/10,),
                )
              ],
            ),
          ),
                    Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/demo3.png"),
                SizedBox(height: 10),
                Text("Facts & More", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Discover fascinating facts about animals with Wikipedia information while enjoying their unique sounds"
                      , style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                      textAlign: TextAlign.center,),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Ppd()));
                  },
                  child: Image.asset("assets/img/paw_blue.png",
                  width: MediaQuery.sizeOf(context).width/10,
                  height: MediaQuery.sizeOf(context).height/10,),
                )
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}