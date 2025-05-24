import 'package:animals/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ppd extends StatefulWidget {
  const Ppd({super.key});

  @override
  State<Ppd> createState() => _PpdState();
}

class _PpdState extends State<Ppd> {

  _acceptPolicy() async {
    SharedPreferences prefValues = await SharedPreferences.getInstance();
    prefValues.setBool("ppd", true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Terms of Use",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Application is warning you about the app that gives you many services and important imformation for safer and efficient use.\nUser-Generated Content Policy (UGC) By pressing the Accept button, I declare I have read and accepted the following condition of use:",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.verified_user, color: Colors.brown,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "By pressing the Accept button, I declare I have read and accepted the following condition of use:",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.device_unknown_outlined, color: Colors.brown,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "If we find the app is being used outside its terms of use, we may restrict access to it",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.settings, color: Colors.brown,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Any tipe of modification of the app or its components is not allowed",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.list_rounded, color: Colors.brown,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Privacy Policy may be updated from time to time for any reason. We will notify you of any changes to our Privacy Policy by posting the new Privacy Policy here.",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.cloud_off, color: Colors.brown,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "We do not share any kind of your Personal Data with third parties",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text("You can find out more information by clicking on the"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Following link:"),
                Text(
                  "Terms and conditions of use",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _acceptPolicy();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard("")),
                  );
                },
                child: Text("Accept", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.brown,
                ),
              ),
            ),
            Image.asset("assets/img/puppies.png",
            width: MediaQuery.sizeOf(context).width/1.2,
            height:  MediaQuery.sizeOf(context).height/8,)
          ],
        ),
      ),
    );
  }
}
