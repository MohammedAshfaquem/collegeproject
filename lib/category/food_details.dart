import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_project/Category/quantity_controller.dart';
import 'package:college_project/Donate/donate_controller.dart';
import 'package:college_project/persondetails/persondetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatelessWidget {
  CategoryDetails({
    super.key,
    required this.category,
    required this.function,
    required this.image,
  });

  final String category;
  final VoidCallback function;
  final foodnamecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final String image;

  void showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagcontroller = Provider.of<Donate>(context, listen: false);
    final categorycontroller = Provider.of<QuantityController>(
      context,
    );

    return WillPopScope(
      onWillPop: () async {
        imagcontroller.clearImageCache();
        categorycontroller.reset();
        imagcontroller.reset();
        imagcontroller.selectedvalue = null;
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 230.h,
                      color: Color(0xff247D7F),
                    ),
                    Container(
                        height: 600.h,
                        width: 550.w,
                        color: Theme.of(context).colorScheme.secondary),
                  ],
                ),
                Positioned(
                  top: 170.h,
                  right: 30.r,
                  child: Container(
                    padding: EdgeInsets.all(18).w,
                    child: Consumer<Donate>(
                      builder: (context, value, child) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title', style: TextStyle(color: Colors.grey)),
                          TextFormField(
                            maxLength: 15,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'[a-zA-Z\s]')), // Allows letters and spaces
                            ],
                            style: TextStyle(color: Colors.black),
                            validator: (name) =>
                                name!.isEmpty ? 'Please enter your name' : null,
                            controller: foodnamecontroller,
                            decoration: InputDecoration(
                              hintText: 'Food Name',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey),
                            ),
                            height: 60,
                            width: 300,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(15),
                              underline: SizedBox(),
                              dropdownColor: Color.fromARGB(255, 39, 172, 174),
                              padding: EdgeInsets.all(10),
                              value: value.currentvalue,
                              hint: Text(
                                "Choose",
                                style: TextStyle(color: Colors.grey),
                              ),
                              items: value.freeornot.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: value.freeornotcontroll,
                            ),
                          ),
                          if (value.currentvalue == 'Price')
                            TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .digitsOnly, // Ensures only digits are allowed
                              ],
                              validator: (value) =>
                                  value!.isEmpty ? 'Price required' : null,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              maxLength: 3,
                              style: TextStyle(color: Colors.black),
                              controller: pricecontroller,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                counterText: "",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "RS",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                hintText: "Enter The price",
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'[a-zA-Z\s]')), // Allows letters and spaces
                            ],
                            style: TextStyle(color: Colors.black),
                            validator: (description) => description!.isEmpty
                                ? 'Description is required'
                                : null,
                            controller: descriptioncontroller,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Description About Food',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          Text("Pictures",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Column(
                                children: [
                                  value.isLoading
                                      ? Container(
                                          height: 60.h,
                                          width: 60.h,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.black)))
                                      : value.imageurl == null
                                          ? GestureDetector(
                                              onTap: () async {
                                                value.showimagepicker(context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(17)
                                                          .w,
                                                ),
                                                height: 60.h,
                                                width: 60.w,
                                                child: Icon(Icons.add),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                              ),
                                              height: 60.h,
                                              width: 60.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Center(
                                                        child: Icon(Icons.error,
                                                            color: Colors.red));
                                                  },
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          height: 60.h,
                                                          width: 60.h,
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )),
                                                  imageUrl:
                                                      value.imageurl.toString(),
                                                ),
                                              ),
                                            ),
                                ],
                              ),
                              SizedBox(width: 40.w),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black),
                                ),
                                height: 50,
                                width: 185,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Quantity:",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black),
                                    ),
                                    IconButton(
                                        onPressed: categorycontroller.decrement,
                                        icon: Icon(
                                          LineAwesomeIcons.minus_circle_solid,
                                          color: Colors.black,
                                        )),
                                    Text(
                                      "${categorycontroller.quantity}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    IconButton(
                                        iconSize: 25,
                                        onPressed: categorycontroller.increment,
                                        icon: Icon(
                                          LineAwesomeIcons.plus_circle_solid,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    height: 520.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25).w,
                        color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 35.h,
                  left: 40.r,
                  child: Consumer<Donate>(
                    builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          if (value.currentvalue == null ||
                              value.currentvalue!.isEmpty) {
                            showCustomSnackBar(
                                context, "Please select an option.");
                            return;
                          }

                          if (value.imageurl == null ||
                              value.imageurl!.isEmpty) {
                            showCustomSnackBar(
                                context, "Please select an image.");
                            return;
                          }

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PersonDetails(
                              option: value.currentvalue == 'Free'
                                  ? "Free"
                                  : "Rs:" + pricecontroller.text.toString(),
                              images: value.imageurl.toString(),
                              foodname: foodnamecontroller.text,
                              category: value.selectedvalue.toString(),
                              description: descriptioncontroller.text,
                              quantity: categorycontroller.quantity.toString(),
                            );
                          }));
                        } else {
                          showCustomSnackBar(context,
                              "Please fill in all the required fields.");
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Person Details",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 60.h,
                        width: 350.w,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 40.r,
                  top: 70.h,
                  child: Text(
                    category,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
