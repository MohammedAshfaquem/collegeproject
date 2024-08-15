import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/category/category_page.dart';
import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/About%20us/feedbackmodel.dart';
import 'package:college_project/Carousalslider2/imagecontroller.dart';
import 'package:college_project/Carousalslider2/imagemovingmodel.dart';
import 'package:college_project/Profile/profiletile/profiepage.dart';
import 'package:college_project/edit.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<String?> getusername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName;
    } else {
      return null;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    List<imagemovingmodel> imagelist = [
      imagemovingmodel(
        image: 'lib/images/foodimage.jpg',
      ),
      imagemovingmodel(
        image: 'lib/images/fooddonate2.jpg',
      ),
      imagemovingmodel(
        image: 'lib/images/foodhelpda.jpg',
      ),
    ];
    final slideimagecontroller =
        Provider.of<Slideimagecontroller>(listen: false, context);
    final imagecontroller = Provider.of<imgcontroller>(listen: false, context);
    final emailedit = Provider.of<editcontroller>(listen: false, context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 0.w,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
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
                        FutureBuilder(
                          future: getusername(),
                          builder: (context, snapshot) => Text(
                            snapshot.data.toString(),
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
                      borderRadius: BorderRadius.circular(50).w,
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
                            borderRadius: BorderRadius.circular(100).w,
                          ),
                          height: 60.h,
                          width: 60.w,
                          child: imagecontroller.image != null
                              ? Image.file(
                                  imagecontroller.image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'lib/images/avtar.avif',
                                  height: 10,
                                ),
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
                      options: CarouselOptions(
                          autoPlayCurve: Easing.standard,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 100,
                          enlargeFactor: 0,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          viewportFraction: 0.99,
                          onPageChanged: (index, reason) {
                            Provider.of<Slideimagecontroller>(
                                    listen: false, context)
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
                                FadeInRightBig(
                                  duration: Duration(milliseconds: 700),
                                  delay: Duration(milliseconds: 500),
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
                Positioned(
                  bottom: 10,
                  left: 130,
                  child: Container(
                    height: 5,
                    width: 5,
                    child: FadeInRightBig(
                      duration: Duration(milliseconds: 600),
                      delay: Duration(milliseconds: 400),
                      child: Consumer<Slideimagecontroller>(
                        builder: (context, value, child) =>
                            AnimatedSmoothIndicator(
                                effect: ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 9,
                                  activeDotColor: Color(0xff247D7F),
                                ),
                                activeIndex: value.selectedindex,
                                count: 3),
                      ),
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
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
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
                                    builder: (context) => CategoryDonate(
                                      cheight: true,
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                  color: Color(0xff247D7F),
                                  borderRadius: BorderRadius.circular(20)),
                              width: 175.w,
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
                                      onpressed: () {
                                        Navigator.maybePop(context);
                                      },
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                  color: Color(0xff247D7F),
                                  borderRadius: BorderRadius.circular(20).w),
                              width: 175.w,
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
                    "What People Feel About us",
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
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
