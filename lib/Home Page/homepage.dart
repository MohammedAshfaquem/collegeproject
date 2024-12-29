import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Home%20Page/donate_card.dart';
import 'package:college_project/category/category_page.dart';
import 'package:college_project/Donate/available_foods.dart';
import 'package:college_project/Home%20Page/feedbackmodel.dart';
import 'package:college_project/Carousal%20Slider/imagecontroller.dart';
import 'package:college_project/Carousal%20Slider/imagemovingmodel.dart';
import 'package:college_project/Profile/ProfileTile/profiepage.dart';
import 'package:college_project/getdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class Homepage extends StatefulWidget {
  Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isFirstVisit = true;

  @override
  void initState() {
    super.initState();
    _checkFirstVisit();
    _initializeZego();
  }

  Future<void> _initializeZego() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await ZIMKit().connectUser(
          id: user.uid,
          name: user.displayName ?? "Unknown",
        );
        print("Zego connected successfully!");
      } else {
        print("User is not authenticated, cannot connect to Zego.");
      }
    } catch (e) {
      print("Error connecting to Zego: $e");
    }
  }

  void _checkFirstVisit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool visitedBefore = prefs.getBool('visited_before') ?? false;

    if (visitedBefore) {
      setState(() {
        isFirstVisit = false; // No animation if it's not the first visit
      });
    } else {
      // Set the flag to true after the first visit
      await prefs.setBool('visited_before', true);
    }
  }

  bool isSearchFocused = false; // Shared state for navigation bar visibility
  void updateNavigationBarVisibility(bool isFocused) {
    setState(() {
      isSearchFocused = isFocused;
    });
  }

  bool _isloading = true;


  Future<Widget> getimage() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userdoc.exists) {
      var data = userdoc.data() as Map<String, dynamic>;
      return Skeletonizer(
        enabled: _isloading,
        child: Image.network(
          data['image'] as String,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              Future.microtask(
                () {
                  if (mounted) {
                    setState(() {
                      _isloading = false;
                    });
                  }
                },
              );

              return child;
            } else {
              return Skeletonizer(
                enabled: true,
                child: Container(
                  color: Colors.grey.shade100,
                ),
              );
            }
          },
          fit: BoxFit.fill,
        ),
      );
    } else {
      return Image.asset(
        "lib/images/profile.jpg",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final getdata = GetData();
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              isFirstVisit
                  ? FadeInDown(
                      duration: Duration(milliseconds: 600),
                      delay: Duration(milliseconds: 600),
                      child: Container(
                        height: 60.h,
                        width: 350.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hello!",
                                    style: GoogleFonts.poppins(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                                FutureBuilder(
                                    future: getdata.getUsername(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          width: 200.w,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            snapshot.data.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                                color: Color(0xff247D7F)),
                                          ),
                                        );
                                      } else {
                                        return Skeletonizer(
                                          enabled: true,
                                          child: Container(
                                            width: 200.w,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              'Loading',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: Color(0xff247D7F)),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                            FutureBuilder(
                                future: getimage(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(50).w,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProfilePage(
                                                onpressed: () {
                                                  Navigator.pop(context);
                                                },
                                                showbackbutton: true,
                                                height: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10).w,
                                            ),
                                            height: 60.h,
                                            width: 60.w,
                                            child: snapshot.data),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100).r,
                                        child: Image.asset(
                                          "lib/images/profile.jpg",
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100).r,
                                      ),
                                      height: 60.h,
                                      width: 60.w,
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 60.h,
                      width: 350.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello!",
                                  style: GoogleFonts.poppins(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                              FutureBuilder(
                                  future: getdata.getUsername(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        width: 200.w,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          snapshot.data.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                              color: Color(0xff247D7F)),
                                        ),
                                      );
                                    } else {
                                      return Skeletonizer(
                                        enabled: true,
                                        child: Container(
                                          width: 200.w,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            'Loading',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                                color: Color(0xff247D7F)),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                          SizedBox(
                            width: 60.w,
                          ),
                          FutureBuilder(
                              future: getimage(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(50).w,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProfilePage(
                                              onpressed: () {
                                                Navigator.pop(context);
                                              },
                                              showbackbutton: true,
                                              height: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10).w,
                                          ),
                                          height: 60.h,
                                          width: 60.w,
                                          child: snapshot.data),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100).r,
                                      child: Image.asset(
                                        "lib/images/profile.jpg",
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100).r,
                                    ),
                                    height: 60.h,
                                    width: 60.w,
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Container(
                      height: 180.h,
                      width: 360.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(18.r)),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            autoPlayCurve: Easing.standard,
                            pauseAutoPlayOnTouch: true,
                            aspectRatio: 100.r,
                            enlargeFactor: 0,
                            initialPage: 0,
                            enlargeCenterPage: true,
                            viewportFraction: 1.10.r,
                            onPageChanged: (index, reason) {
                              Provider.of<SlideImageController>(
                                      listen: false, context)
                                  .updateindex(index);
                            },
                            height: 178.h,
                            autoPlay: true,
                            autoPlayAnimationDuration: Duration(seconds: 1)),
                        items: imagelist.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  isFirstVisit
                                      ? FadeInRightBig(
                                          duration: Duration(milliseconds: 700),
                                          delay: Duration(milliseconds: 500),
                                          child: Container(
                                            height: 178.h,
                                            width: 375.w,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: Image.asset(
                                                height: 100.h,
                                                i.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 178.h,
                                          width: 375.w,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            child: Image.asset(
                                              height: 100.h,
                                              i.image,
                                              fit: BoxFit.cover,
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
                    bottom: 10.h,
                    left: 150.w,
                    child: Container(
                      height: 5,
                      width: 5,
                      child: isFirstVisit
                          ? FadeInRightBig(
                              duration: Duration(milliseconds: 600),
                              delay: Duration(milliseconds: 400),
                              child: Consumer<SlideImageController>(
                                builder: (context, value, child) =>
                                    AnimatedSmoothIndicator(
                                        effect: ExpandingDotsEffect(
                                          dotHeight: 8.h,
                                          dotWidth: 9.w,
                                          activeDotColor: Color(0xff247D7F),
                                        ),
                                        activeIndex: value.selectedindex,
                                        count: 3),
                              ),
                            )
                          : Consumer<SlideImageController>(
                              builder: (context, value, child) =>
                                  AnimatedSmoothIndicator(
                                      effect: ExpandingDotsEffect(
                                        dotHeight: 8.h,
                                        dotWidth: 9.w,
                                        activeDotColor: Color(0xff247D7F),
                                      ),
                                      activeIndex: value.selectedindex,
                                      count: 3),
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              isFirstVisit
                  ? FadeInDown(
                      duration: Duration(milliseconds: 700),
                      delay: Duration(milliseconds: 500),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 22.w,
                        ),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Choose Your Role',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  DonateCard(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryDonate(
                                              cheight: true,
                                            ),
                                          ),
                                        );
                                      },
                                      text: "Donate",
                                      imageurl: 'lib/images/foodelivary.png'),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  DonateCard(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Donatepage(
                                              showbackbutton: true,
                                              onpressed: () {
                                                Navigator.maybePop(context);
                                              },
                                              onSearchFocusChange:
                                                  updateNavigationBarVisibility, // Pass callback
                                            ),
                                          ),
                                        );
                                      },
                                      text: "Find Food",
                                      imageurl: 'lib/images/search.png'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        left: 22.w,
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Choose Your Role',
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              children: [
                                DonateCard(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CategoryDonate(
                                            cheight: true,
                                          ),
                                        ),
                                      );
                                    },
                                    text: "Donate",
                                    imageurl: 'lib/images/foodelivary.png'),
                                SizedBox(
                                  width: 10.w,
                                ),
                                DonateCard(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Donatepage(
                                            showbackbutton: true,
                                            onpressed: () {
                                              Navigator.maybePop(context);
                                            },
                                            onSearchFocusChange:
                                                updateNavigationBarVisibility, // Pass callback
                                          ),
                                        ),
                                      );
                                    },
                                    text: "Find Food",
                                    imageurl: 'lib/images/search.png'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 20.h,
              ),
              isFirstVisit
                  ? FadeInDown(
                      duration: Duration(milliseconds: 800),
                      delay: Duration(milliseconds: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: Text("What People Feel About us",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: Color(0xff247D7F))),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25.w),
                          child: Text("What People Feel About us",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: Color(0xff247D7F))),
                        ),
                      ],
                    ),
              SizedBox(
                height: 5.h,
              ),
              isFirstVisit
                  ? FadeInDown(
                      duration: Duration(milliseconds: 900),
                      delay: Duration(milliseconds: 700),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          height:
                              155.0, // Adjust the height as per your requirement
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              feedbackmodel(
                                  feedback:
                                      'Mealio app is very helpful and the services are highly useful',
                                  name: 'Muzthafa Panakkad'),
                              feedbackmodel(
                                  feedback:
                                      'Mealio app is very helpful and the services are highly useful',
                                  name: 'Mohammed Ansil'),
                              feedbackmodel(
                                  feedback:
                                      'Mealio app is very helpful and the services are highly useful',
                                  name: 'Abhay Krishnan K'),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 155.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            feedbackmodel(
                                feedback:
                                    'Mealio app is very helpful and the services are highly useful',
                                name: 'Muzthafa Panakkad'),
                            feedbackmodel(
                                feedback:
                                    'Mealio app is very helpful and the services are highly useful',
                                name: 'Mohammed Ansil'),
                            feedbackmodel(
                                feedback:
                                    'Mealio app is very helpful and the services are highly useful',
                                name: 'Abhay Krishnan K'),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
