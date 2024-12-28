import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:college_project/category/quantitycontroller.dart';
import 'package:college_project/eachChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// ignore: must_be_immutable
class Detailspage extends StatefulWidget {
  var foodname;
  var description;
  var firstname;
  var cntctno;
  var course;
  var imageurl;
  var option;
  var lname;
  var time;
  var quantity;
  var donationId;
  var userimage;
  var uid;
  var username;
  Detailspage({
    super.key,
    required this.lname,
    this.option,
    this.foodname,
    this.description,
    this.firstname,
    this.cntctno,
    this.course,
    this.imageurl,
    required this.time,
    required this.quantity,
    required this.donationId,
    required this.userimage,
    required this.uid,
    required this.username,
  });

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  bool isloading = true;
  void updatefooddetails(donationId, quantity) async {
    print("donationId ;- $donationId  and quantity;- $quantity");
    final finalQuantity = int.parse(widget.quantity) - quantity;
    // Reference to the Firestore collection
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    try {
      // Query to find documents where donationId matches
      QuerySnapshot querySnapshot =
          await notes.where('donationid', isEqualTo: donationId).get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through the matching documents and update the quantity
        for (var doc in querySnapshot.docs) {
          await notes.doc(doc.id).update({
            'quantity': finalQuantity.toString(), // Update the quantity field
          });
          print("Updated quantity for document ID: ${doc.id}");
        }
      } else {
        print("No documents found with donationId: $donationId");
      }
    } catch (e) {
      print("Failed to update quantity: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // Schedule the update after the current frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categorycontroller =
          Provider.of<QuantityController>(context, listen: false);
      // Convert to int and update quantity
      categorycontroller.quantity =
          int.tryParse(widget.quantity) ?? 0; // Fallback to 0 if parsing fails
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    final categorycontroller =
        Provider.of<QuantityController>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            color: Theme.of(context).colorScheme.primary,
            LineAwesomeIcons.angle_left_solid,
          ),
        ),
        title: Text("Food Details",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            )),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20).w,
              child: Consumer<Donate>(
                builder: (context, value, child) => ClipRRect(
                  borderRadius: BorderRadius.circular(30).w,
                  child: Hero(
                    tag: 'image${widget.imageurl}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        width: 500.w,
                        height: 200.h,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            Future.microtask(
                              () {
                                if (mounted) {
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              },
                            );

                            return child;
                          } else {
                            return Skeletonizer(
                              enabled: true,
                              child: Container(
                                height: 200.h,
                                width: 500.w,
                                color: Colors.grey.shade100,
                              ),
                            );
                          }
                        },
                        widget.imageurl.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.r,
              ),
              child: ListTile(
                title: Text(
                  widget.foodname.toString(),
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: Text(
                  "${widget.time}",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "${widget.option}",
                    style:
                        GoogleFonts.poppins(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10)
                  .w,
              child: Container(
                height: 85.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        radius: 30,
                        child: Image.network(
                          widget.userimage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'lib/images/profile.jpg', // Replace with your asset path
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 130,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${widget.firstname} ${widget.lname}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.cntctno}",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // ZIMKit().connectUser(
                        //   id: FirebaseAuth.instance.currentUser!.uid,
                        //   name:
                        //       FirebaseAuth.instance.currentUser!.displayName ??
                        //           "",
                        // );

                        try {
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            ZIMKit().connectUser(
                              id: user.uid,
                              name: user.displayName ?? "Unknown",
                            );
                            print("Zego connected successfully!");
                          } else {
                            print(
                                "User is not authenticated, cannot connect to Zego.");
                          }
                        } catch (e) {
                          print("Error connecting to Zego: $e");
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EachChatScreen(
                                conversationId: widget.uid,
                                conversationName: widget.username,
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff247D7F),
                            borderRadius: BorderRadius.circular(100)),
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        FlutterPhoneDirectCaller.callNumber(
                            "${widget.cntctno}");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff247D7F),
                            borderRadius: BorderRadius.circular(100)),
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.r, top: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About details",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          height: 200.h,
                          child: Text(
                            "${widget.description}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      title: "Please confirm your order",
                      animType: QuickAlertAnimType.scale,
                      showCancelBtn: true,
                      onConfirmBtnTap: () {
                        updatefooddetails(
                            widget.donationId, categorycontroller.quantity);
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 1,
                        ),
                        Icon(
                          Icons.card_travel,
                          color: Colors.white,
                        ),
                        Text(
                          'Buy',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.sp),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15).w,
                        color: Color(0xff247D7F)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 105,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Text(
                      //   'Qty:',
                      //   style: TextStyle(color: Colors.black),
                      // ),
                      GestureDetector(
                        onTap: categorycontroller.quantity > 1
                            ? categorycontroller.decrement
                            : null, // Set to null to disable the tap
                        child: Opacity(
                          opacity: categorycontroller.quantity > 1
                              ? 1.0
                              : 0.2, // Make it visually disabled
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: Icon(
                              LineAwesomeIcons.minus_solid,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${categorycontroller.quantity}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: categorycontroller.quantity <
                                int.parse(widget.quantity)
                            ? categorycontroller.increment
                            : null, // Set to null to disable the tap
                        child: Opacity(
                          opacity: categorycontroller.quantity <
                                  int.parse(widget.quantity)
                              ? 1.0
                              : 0.2, // Make it visually disabled
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: Icon(
                              LineAwesomeIcons.plus_solid,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
