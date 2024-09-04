import 'package:college_project/OnBoardingScreens/1dope.dart';
import 'package:college_project/OnBoardingScreens/2dope.dart';
import 'package:college_project/OnBoardingScreens/3dope.dart';
import 'package:college_project/OnBoardingScreens/dopcontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dopescreens extends StatefulWidget {
  const Dopescreens({super.key});

  @override
  State<Dopescreens> createState() => _DopescreensState();
}

class _DopescreensState extends State<Dopescreens> {
  @override
  Widget build(BuildContext context) {
    final dopecontroller = Provider.of<DopeController>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) => dopecontroller.updateindex(value),
            controller: dopecontroller.controller,
            children: [firstdope(), secounddope(), thirddope()],
          ),
          Container(
              alignment: Alignment(-0.80, 0.77),
              child: SmoothPageIndicator(
                controller: dopecontroller.controller,
                count: 3,
                effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.grey,
                    activeDotColor: Color(0xff247D7F)),
              ))
        ],
      ),
    );
  }
}
