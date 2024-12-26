import 'package:college_project/OnBoardingScreens/Dopescrees.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3),() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dopescreens()));
    },);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("lib/images/bgfile.avif",fit: BoxFit.fill,)),
          Positioned(
            top: 240,
            child: Image.asset("lib/images/unity.png",height: 300,)),
         Positioned(
          bottom: 50,
          left: 130,
          child: Text('MEALIO',style:GoogleFonts.poppins(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),))
        ],
      ),
    );
  }
}