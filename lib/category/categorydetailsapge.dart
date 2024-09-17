import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:college_project/persondetails/persondetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class catogorydetails extends StatelessWidget {
  catogorydetails({super.key, required this.category, required this.function});
  final String category;
  final VoidCallback function;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final foodnamecontroller = TextEditingController();
    final descriptioncontroller = TextEditingController();
    final pricecontroller = TextEditingController();
    final imagcontroller = Provider.of<Donate>(context, listen: false);

    return PopScope(
      onPopInvoked: (didPop) => imagcontroller.clearImageCache(),
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
                      color: Colors.grey[200],
                    ),
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
                          Text(
                            'Title',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            validator: (name) =>
                                name!.isEmpty ? 'Please enter your name' : null,
                            controller: foodnamecontroller,
                            decoration: InputDecoration(
                              hintText: 'Food Name',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // When the field is focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // When the field is not focused
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // When the field is focused
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey)),
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
                                items: value.freeornot.map(
                                  (String value) {
                                    return DropdownMenuItem<String>(

                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ));
                                  },
                                ).toList(),
                                onChanged: value.freeornotcontroll,
                              )),
                          if (value.currentvalue == 'Price')
                      
                            TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? 'Price required' : null,
                              
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              maxLength: 3,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: pricecontroller,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // When the field is focused
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
                                  borderSide: BorderSide(
                                      color: Colors
                                          .black), // When the field is focused
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey), // When the field is not focused
                                ),
                              ),
                            ),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            controller: descriptioncontroller,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Description About Food',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // When the field is focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // When the field is not focused
                              ),
                            ),
                          ),
                          Text(
                            "pictures",
                            style: TextStyle(color: Colors.black),
                          ),
                          value.imageurl == null
                              ? GestureDetector(
                                  onTap: () async {
                                    value.showimagepicker(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(17).w),
                                    height: 50.h,
                                    width: 50.w,
                                    child: Icon(Icons.add),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17)),
                                  height: 50.h,
                                  width: 50.w,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17).w,
                                      child: CachedNetworkImage(
                                        errorWidget: (context, url, error) {
                                           return Center(
                                          child: Icon(Icons.error,
                                              color: Colors.red),
                                        );
                                        
                                        },
                                        placeholder: (context, url) => CircularProgressIndicator(
                                       
                                        ),
                                        imageUrl: value.imageurl.toString(),
                                        
                                      )),
                                ),
                        ],
                      ),
                    ),
                    height: 520.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25).w,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
                Positioned(
                  bottom: 35.h,
                  left: 40.r,
                  child: Consumer<Donate>(
                    builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            print(foodnamecontroller.text);
                            print(descriptioncontroller.text);
                            print(value.image);

                            return persondetails(
                              option: value.currentvalue == 'Free'
                                  ? "Free"
                                  : "Rs:" + pricecontroller.text.toString(),
                              images: value.imageurl.toString(),
                              foodname: foodnamecontroller.text,
                              category: value.selectedvalue.toString(),
                              description: descriptioncontroller.text,
                            );
                          }));
                          print(pricecontroller.text);
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
                        )),
                        decoration: BoxDecoration(
                            color: Color(0xff247D7F),
                            borderRadius: BorderRadius.circular(50)),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
