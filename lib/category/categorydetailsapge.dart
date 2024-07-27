import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:college_project/persondetails/persondetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class cdetails extends StatelessWidget {
  cdetails({super.key, required this.category});
  final String category;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final foodnamecontroller = TextEditingController();
    final descriptioncontroller = TextEditingController();

    return Scaffold(
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
                    height: 550.h,
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
                  child: Consumer<Donatecontroler>(
                    builder: (context, value, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextFormField(
                          style: TextStyle(color:Theme.of(context).colorScheme.primary),
                          validator: (name) =>
                              name!.isEmpty ? 'Please enter your name' : null,
                          controller: foodnamecontroller,
                          decoration: InputDecoration(
                            hintText: 'Food Name',
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
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
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey)),
                            height: 60,
                            width: 300,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(25),
                              underline: SizedBox(),
                              dropdownColor: Color(0xff247D7F),
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
                                            color: Theme.of(context).colorScheme.primary),
                                      ));
                                },
                              ).toList(),
                              onChanged: value.freeornotcontroll,
                            )),
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          controller: descriptioncontroller,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Description About Food',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15).w,
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15).w,
                              borderSide: BorderSide(color:Theme.of(context).colorScheme.surface),
                            ),
                          ),
                        ),
                        Text("pictures"),
                        value.image == null
                            ? GestureDetector(
                                onTap: () async {
                                  value.showimagepicker(context);
                                  /* Map<Permission, PermissionStatus> status = await [
                        Permission.storage,
                        Permission.camera,
                      ].request();
                      if (status[Permission.storage]!.isGranted &&
                          status[Permission.camera]!.isGranted) {
                        showimagepicker(context);
                      } else {
                        Text("no permisiion granted");
                      }*/
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
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(17)),
                                height: 50.h,
                                width: 50.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17).w,
                                  child: Image.file(
                                    value.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  height: 520.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25).w,
                      color:Theme.of(context).colorScheme.surface),
                ),
              ),
              Positioned(
                bottom: 10.h,
                left: 40.r,
                child: Consumer<Donatecontroler>(
                  builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          print(foodnamecontroller.text);
                          print(descriptioncontroller.text);
                          print(value.image);
                          return persondetails(
                            option: value.currentvalue.toString(),
                            images: value.savedimage,
                            foodname: foodnamecontroller.text,
                            description: descriptioncontroller.text,
                            category: value.selectedvalue.toString(),
                          );
                        }));
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
    );
  }
}
