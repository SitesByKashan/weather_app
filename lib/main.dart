import 'package:flutter/material.dart';
import 'package:weather_app/pages/splash_page.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home : SplashPage(),
    );
  }
}

class MyImages {

  static String logoImage = "assets/images/weather_logo_image.png";
}









class Page extends StatefulWidget {
  const Page({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
   String _x = ""; // Variable to hold the value

  // Custom setter for _x
  set x(String value) {
    _x = value;
    _onXChanged(); // Call the function when x changes
  }

  // Function to perform when x changes
  void _onXChanged() {
    // Do something with the new value of x
    print("x changed to: $_x");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Variable Change Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  
                });
                x = value; // Use the setter to change the value
              },
              decoration: const InputDecoration(
                hintText: "Enter new value for x",
              ),
            ),
            const SizedBox(height: 20),
            Text("Current value of x: $_x"),
          ],
        ),
      ),
    );
  }
}