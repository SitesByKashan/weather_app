import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/pages/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),() {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()));});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Stack(
              children: [
                Container(
                        height: double.infinity,
                        width: double.infinity ,     
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                colors:  [
                  Color(0xFF1f274b),
                   Color(0xFF933dac)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.8,
                  1
                ],
                 )
              ),
                ),    
                Center(
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(''),
                     Column(
                      children: [
                         SizedBox(
                      width: 200,
                      height: 200, 
                     child: Image.asset( MyImages.logoImage, fit: BoxFit.cover,)
                      ),

                      RichText(
                        text: const TextSpan(
                          text: 'Weather',
                          style: TextStyle(color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: ' Forcast',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                          ]
                        )
                      ),
                      ],
                     ),

                     
                       const Column(
                         children: [
                             Text('Developed by : M.Kashan Malik Awan',
                            style: TextStyle(color: Colors.amber, 
                            fontSize: 15, fontWeight: FontWeight.bold),),
                         SizedBox(height: 20,),
                         ],
                       )
                      
                    ],
                  ),
                ),
                
                      
              ],
            ),

      
    );
  }
}

