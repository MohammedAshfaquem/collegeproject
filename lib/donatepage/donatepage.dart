import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/donatepage/donateDetailspage.dart';
import 'package:college_project/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Donatepage extends StatefulWidget {
  Donatepage(
      {super.key,
      this.showbackbutton = false,
      required this.onpressed,
      this.onSearchFocusChange});
  final bool showbackbutton;
  final VoidCallback onpressed;
  final ValueChanged<bool>? onSearchFocusChange;

  @override
  State<Donatepage> createState() => _DonatepageState();
}

class _DonatepageState extends State<Donatepage> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(); // Track focus
  String searchQuery = '';
  String selectedFilter = 'All'; // Default filter showing all options

  void updateFilter(String newFilter) {
    setState(() {
      selectedFilter = newFilter;
    });
  }

  @override
  void initState() {
    super.initState();

    // Listen to focus changes and notify parent via callback
    searchFocusNode.addListener(() {
      widget.onSearchFocusChange?.call(searchFocusNode.hasFocus); // Safe call
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FireStoreService fireStoreService = FireStoreService();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: widget.onpressed,
            icon: widget.showbackbutton
                ? Icon(
                    LineAwesomeIcons.angle_left_solid,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : SizedBox(),
          ),
          elevation: 2,
          title: Text('Available Foods',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Theme.of(context).colorScheme.primary)),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Colors.black),
                focusNode: searchFocusNode, // Attach the FocusNode
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black),
                  suffixIcon: PopupMenuButton<String>(
                    color: Color.fromARGB(255, 39, 172, 174),
                    icon: Icon(Icons.tune, color: Colors.black),
                    onSelected: updateFilter,
                    itemBuilder: (BuildContext context) {
                      return {'All', 'Free', 'Price'}.map((String choice) {
                        return PopupMenuItem<String>(
                          textStyle: TextStyle(color: Colors.black),
                          value: choice,
                          child: Text(
                            choice,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                    stream: fireStoreService.getNotesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final notesList = snapshot.data!.docs;

                        // Filter the notes list based on search query and selected filter
                        final filteredNotesList = notesList.where((document) {
                          final data = document.data() as Map<String, dynamic>;
                          final foodname =
                              data['food name']?.toString().toLowerCase() ?? '';
                          final option = data['option']?.toString() ?? '';
                          final quantity =
                              int.tryParse(data['quantity'] ?? '0') ?? 0;

                          // Check if the food name matches the search query
                          bool matchesSearch = foodname.contains(searchQuery);
                          // Check if the food matches the selected filter
                          bool matchesFilter = (selectedFilter == 'All') ||
                              (selectedFilter == 'Free' && option == 'Free') ||
                              (selectedFilter == 'Price' && option != 'Free');

                          return matchesSearch && matchesFilter && quantity > 0;
                        }).toList();

                        if (filteredNotesList.isNotEmpty) {
                          return ListView.builder(
                              itemCount: filteredNotesList.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document =
                                    filteredNotesList[index];
                                String docID = document.id;
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                String fname = data['first name'] ?? '';
                                String lname = data['last name'] ?? '';
                                String number = data['number'] ?? '';
                                String course = data['course'] ?? '';
                                String foodname = data['food name'] ?? '';
                                String option = data['option'] ?? '';
                                String description = data['description'] ?? '';
                                String imageurl = data['image'] ?? '';
                                String dateTime = data['time'] ?? '';
                                String quantity = data['quantity'] ?? '';
                                String donationid = data['donationid'] ?? '';
                                String userimage = data['userimage'] ?? '';

                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Detailspage(
                                              userimage: userimage,
                                              cntctno: number,
                                              course: course,
                                              lname: lname,
                                              foodname: foodname,
                                              user: fname,
                                              option: option,
                                              description: description,
                                              imageurl: imageurl,
                                              time: dateTime,
                                              quantity: quantity,
                                              donationId: donationid,
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      height: 120.h,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Hero(
                                            tag: 'image${imageurl}',
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                imageurl,
                                                fit: BoxFit.cover,
                                                width: 120.w,
                                                height: 90.h,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Skeletonizer(
                                                      enabled: true,
                                                      child: Container(
                                                        color: Colors
                                                            .grey.shade100,
                                                        height: 90.h,
                                                        width: 120.w,
                                                      ));
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(foodname,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 19.sp)),
                                                // Text(
                                                //   course,
                                                //   style: TextStyle(
                                                //       fontWeight:
                                                //           FontWeight.w500,
                                                //       color: Colors.black),
                                                // ),
                                                Text(
                                                  dateTime.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15.sp,
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Text("Qty:$quantity",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black)),
                                              Text(
                                                option,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: Column(
                              children: [
                                SizedBox(height: 190),
                                Container(
                                  height: 200,
                                  child: Lottie.asset(
                                      "lib/Animations/emtypage.json",
                                      repeat: false,
                                      fit: BoxFit.fill),
                                ),
                                Text(
                                  "No Data Found!",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(height: 190),
                              Container(
                                height: 200,
                                child: Lottie.asset(
                                    "lib/Animations/emtypage.json",
                                    repeat: false,
                                    fit: BoxFit.fill),
                              ),
                              Text(
                                "No Data Found!",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
