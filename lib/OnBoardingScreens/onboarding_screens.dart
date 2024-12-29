import 'package:college_project/OnBoardingScreens/1_screen.dart';
import 'package:college_project/OnBoardingScreens/2_screen.dart';
import 'package:college_project/OnBoardingScreens/3_screen.dart';
import 'package:college_project/OnBoardingScreens/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dopescreens extends StatelessWidget {
  const Dopescreens({super.key});

  @override
  Widget build(BuildContext context) {
    final dopecontroller = Provider.of<OnBoardingController>(
      context,
      listen: false,
    );

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) => dopecontroller.updateindex(value),
            controller: dopecontroller.controller,
            children: [
              FirstScreen(),
              SecondScreen(),
              ThirdScreen(),
            ],
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
            ),
          ),
        ],
      ),
    );
  }
}
