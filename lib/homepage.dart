import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:college_project/donatepage/donateDetailspage.dart';
import 'package:college_project/category/category_page.dart';
import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/feedbackmodel.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/imagemovingmodel.dart';
import 'package:college_project/profiepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    List<imagemovingmodel> imagelist = [
      imagemovingmodel(image: 'lib/images/foodimage.jpg', text: 'First image'),
      imagemovingmodel(
          image: 'lib/images/fooddonate2.jpg', text: 'second image'),
      imagemovingmodel(
          image: 'lib/images/fooddonate3.png', text: 'three image'),
    ];
    final carouselcontroller = CarouselController();
    final controller = Provider.of<Donatecontroler>(listen: false, context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 30.w, right: 29.w),
        child: Column(
          children: [
            FadeInDown(
              duration: Duration(milliseconds: 100),
              delay: Duration(milliseconds: 100),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Consumer<Donatecontroler>(
                          builder: (context, value, child) => Text(
                            value.eeditname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                color: Color(0xff247D7F)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100).w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profilepage(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100).w),
                          height: 60.h,
                          width: 60.w,
                          child: Image.asset("lib/images/avtar.avif"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 170,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    child: CarouselSlider(
                      carouselController: carouselcontroller,
                      options: CarouselOptions(
                          autoPlayCurve: Easing.standard,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 100,
                          enlargeFactor: 0,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          viewportFraction: 0.99,
                          onPageChanged: (index, reason) {
                            Provider.of<imagecontroller>(listen: false, context)
                                .updateindex(index);
                          },
                          height: 170.0,
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(seconds: 3)),
                      items: imagelist.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                FadeInDown(
                                  duration: Duration(milliseconds: 500),
                                  delay: Duration(milliseconds: 300),
                                  child: Container(
                                    height: 178.h,
                                    width: 355,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                        height: 100,
                                        i.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Consumer<imagecontroller>(
                  builder: (context, value, child) => Positioned(
                    bottom: 10,
                    left: 130,
                    child: Container(
                      height: 5,
                      width: 5,
                      child: AnimatedSmoothIndicator(
                          activeIndex: value.selectedindex, count: 3),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FadeInDown(
              duration: Duration(milliseconds: 700),
              delay: Duration(milliseconds: 500),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Your Role',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Color(0xff247D7F),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDonate(),
                                ));
                          },
                          child: Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                                color: Color(0xff247D7F),
                                borderRadius: BorderRadius.circular(22)),
                            width: 170.w,
                            child: Column(
                              children: [
                                Image.asset(
                                  'lib/images/foodelivary.png',
                                  height: 150.h,
                                ),
                                Text(
                                  "Donate Food",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Donatepage(
                                    showbackbutton: true,
                                  ),
                                ));
                          },
                          child: Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                                color: Color(0xff247D7F),
                                borderRadius: BorderRadius.circular(22).w),
                            width: 170.w,
                            child: Column(
                              children: [
                                Image.asset(
                                  'lib/images/search.png',
                                  height: 150.h,
                                ),
                                Text(
                                  "Find Food",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            FadeInDown(
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 600),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "What people feel About us",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xff247D7F)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FadeInDown(
              duration: Duration(milliseconds: 900),
              delay: Duration(milliseconds: 700),
              child: SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    feedbackmodel(
                        feedback:
                            'Mealio app is very helpfull and the services are highly usefull',
                        name: 'Muzthafa panakkad'),
                    feedbackmodel(
                        feedback:
                            'Mealio app is very helpfull and the services are highly usefull',
                        name: 'Mohammed Ansil'),
                    feedbackmodel(
                        feedback:
                            'Mealio app is very helpfull and the services are highly usefull',
                        name: 'Abhay Krishna'),
                  ],
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
