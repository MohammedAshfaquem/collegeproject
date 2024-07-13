import 'dart:io';

import 'package:college_project/doantecontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class donatepage extends StatelessWidget {
  const donatepage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemcontroller = TextEditingController();
    final namecontroller = TextEditingController();
    final coursecontroller = TextEditingController();
    final contactcontroller = TextEditingController();
    final descriptioncontroller = TextEditingController();
    File? imageFile;
    return Consumer<Donatecontroler>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    style: TextStyle(color:  Color(0xff247D7F)),
                    controller: itemcontroller,
                    decoration: InputDecoration(
                        labelText: 'Item name',
                        labelStyle: TextStyle(color:  Color(0xff247D7F)),
                        focusColor:  Color(0xff247D7F),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: TextStyle(color:  Color(0xff247D7F)),
                    keyboardType: TextInputType.name,
                    controller: namecontroller,
                    decoration: InputDecoration(
                        labelText: 'full name',
                        labelStyle: TextStyle(color:  Color(0xff247D7F)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: TextStyle(color:  Color(0xff247D7F)),
                    controller: coursecontroller,
                    decoration: InputDecoration(
                        labelText: 'course',
                        labelStyle: TextStyle(color:  Color(0xff247D7F)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: TextStyle(color:  Color(0xff247D7F)),
                    keyboardType: TextInputType.phone,
                    controller: contactcontroller,
                    maxLength: 10,
                    decoration: InputDecoration(
                        labelText: 'contact no',
                        labelStyle: TextStyle(color:  Color(0xff247D7F)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color:  Color(0xff247D7F)),
                    maxLines: 5,
                    controller: descriptioncontroller,
                    decoration: InputDecoration(
                        labelText: 'description',
                        labelStyle: TextStyle(color:  Color(0xff247D7F)),
                        hintStyle: TextStyle(color:  Color(0xff247D7F)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll( Color(0xff247D7F))),
                        onPressed: () {
                         value.addtile(Itemmodel(
                          date: DateTime.now(),
                            username: namecontroller.text,
                            itemname: itemcontroller.text,
                            course: coursecontroller.text,
                            cntctbo: contactcontroller.text,
                            descriptiom: descriptioncontroller.text,
                          ));
                          itemcontroller.clear();
                          namecontroller.clear();
                          coursecontroller.clear();
                          contactcontroller.clear();
                          descriptioncontroller.clear();
                          
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
