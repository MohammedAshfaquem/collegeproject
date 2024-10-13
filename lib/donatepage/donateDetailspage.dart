import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Category/categorycontroller.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class Detailspage extends StatefulWidget {
  var foodname;
  var itemdes;
  var user;
  var cntctno;
  var course;
  var imageurl;
  var option;
  var lname;
  var time;
  var quantity;
  var donationId;
  Detailspage({
    super.key,
    required this.lname,
    this.option,
    this.foodname,
    this.itemdes,
    this.user,
    this.cntctno,
    this.course,
    this.imageurl,
    required this.time,
    required this.quantity,
    required this.donationId,
  });

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  bool _isloading = true;
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
          Provider.of<CategoryController>(context, listen: false);
      // Convert to int and update quantity
      categorycontroller.quantity =
          int.tryParse(widget.quantity) ?? 0; // Fallback to 0 if parsing fails
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    final categorycontroller =
        Provider.of<CategoryController>(context, listen: false);

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
                  child: Container(
                    child: Image.network(
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
                      widget.imageurl.toString(),
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    height: 200.h,
                    width: 500.w,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.r, top: 10.h),
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
                trailing: Text(
                  "${widget.option}",
                  style: GoogleFonts.poppins(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10)
                      .w,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        child: Image.asset('lib/images/avtar.avif'),
                        radius: 30.r,
                      ),
                    ),
                    SizedBox(
                      width: 10,
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
                            '${widget.user} ${widget.lname}',
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
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      width: 135,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Qty:',
                            style: TextStyle(color: Colors.black),
                          ),
                GestureDetector(
                            onTap: categorycontroller.quantity >
                                    1
                                ? categorycontroller.decrement
                                : null, // Set to null to disable the tap
                            child: Opacity(
                              opacity: categorycontroller.quantity >
                                      1
                                  ? 1.0
                                  : 0.2, // Make it visually disabled
                              child: Container(
                                height: 20,
                                width: 50,
                                child: Icon(
                                  LineAwesomeIcons.minus_circle_solid,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${categorycontroller.quantity}",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
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
                                height: 20,
                                width: 50,
                                child: Icon(
                                  LineAwesomeIcons.plus_circle_solid,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.h,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.r, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About details",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        "${widget.itemdes}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0).w,
              child: GestureDetector(
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
                  child: Row(
                    children: [
                      SizedBox(
                      width: 30,
                      ),
                      Icon(
                        Icons.card_travel,
                        color: Colors.white,
                      ),
                      SizedBox(width: 100,),
                      Text(
                        'Buy',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23.sp),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15).w,
                      color: Color(0xff247D7F)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0).w,
              child: Container(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    Text(
                      '${widget.cntctno}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.sp),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: () {
                          FlutterPhoneDirectCaller.callNumber(
                              "${widget.cntctno}");
                        },
                        child: Text(
                          "call",
                          style: GoogleFonts.poppins(
                              color: Color(0xff247D7F),
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp),
                        ))
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15).w,
                    color: Color(0xff247D7F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
