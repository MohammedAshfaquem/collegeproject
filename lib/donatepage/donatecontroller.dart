import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class DonateController extends ChangeNotifier {
  List<Itemmodel> _itemlist = [];
  List<Itemmodel> get itemlist => _itemlist;
  String _dropdownvalue = 'Free';
  String get dropdownvalue => _dropdownvalue;
  final picker = ImagePicker();
  XFile? image;
  File? savedimage;
  String? imageurl;
  List<String> dropdowmitems = [
    'Bca',
    'Bcom CA',
    'Bcom TT',
    'Bse Electronics',
    'Multi Media',
    'Psychology',
    'Ba English'
  ];
  String? selectedvalue;
  List<String> freeornot = ['Free', 'Price'];
  String? currentvalue;
  String _email = '';
  String get email => _email;
  String _editname = '';
  String get eeditname => _editname;

  imagepickcamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    // if (file == null) return;
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);
    try {
      await referenceimagetoupload.putFile(File(file!.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
    } catch (e) {
      print("error:$e");
    }
    ;
    notifyListeners();
  }

  imagepickgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    // if (file == null) return;
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);
    try {
      await referenceimagetoupload.putFile(File(file!.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
    } catch (e) {
      print("error:$e");
    }
    ;
  }

  void addtile(
    Itemmodel itemmodel,
  ) {
    itemlist.add(itemmodel);
  }

  void deleteitem(int removeitem, BuildContext context) {
    _itemlist.removeAt(removeitem);

    notifyListeners();
  }

  void coursecontroll(newvalue) {
    selectedvalue = newvalue;
    notifyListeners();
  }

  void freeornotcontroll(nvalue) {
    currentvalue = nvalue;
    notifyListeners();
  }

  void setfreeorprice(String option) {
    _dropdownvalue = option;
    notifyListeners();
  }

  void clearImageCache() {
    imageurl = null;
    notifyListeners();
  }

  void editprofile(
      {required String name, required String email, required File image}) {
    _email = email;
    _editname = name;
    savedimage = image;
    notifyListeners();
  }

  void showimagepicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Card(
          semanticContainer: true,
          margin: EdgeInsets.all(25),
          child: Container(
            height: 160,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    imagepickgallery();
                    Navigator.of(context).pop();
                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 70.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                            color: Color(0xff247D7F),
                            borderRadius: BorderRadius.circular(22)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'lib/images/gallery.png',
                              height: 50.h,
                            ),
                            Text(
                              "Choose image",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    imagepickcamera();
                    Navigator.of(context).pop();
                    notifyListeners();
                  },
                  child: Container(
                    height: 70.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        color: Color(0xff247D7F),
                        borderRadius: BorderRadius.circular(22)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'lib/images/camerapick.png',
                          height: 50.h,
                        ),
                        Text(
                          "Take photo",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 90,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // imagefromgallery() async {
  //   final PickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (PickedFile != null) {
  //     image = File(PickedFile.path);
  //     savedimage = image;
  //   } else {
  //     print("no image picked");
  //   }
  //   notifyListeners();
  //   //  if (value != null) {
  //   //    _cropimage(File(value.path));
  //   // }
  // }

  // imagefromcamera() async {
  //   final PickedFile = await picker.pickImage(source: ImageSource.camera);

  //   if (PickedFile != null) {
  //     image = File(PickedFile.path);
  //     savedimage = image;
  //   } else {
  //     print("no image picked");
  //   }
  //   notifyListeners();
  // }
}

class Itemmodel {
  final String foodname;
  final String Category;
  final String description;
  final DateTime date;
  final String fname;
  final String lname;
  final String course;
  final String cntctbo;
  final String option;
  final File image;

  Itemmodel(
      {required this.image,
      required this.fname,
      required this.lname,
      required this.Category,
      required this.description,
      required this.foodname,
      required this.course,
      required this.cntctbo,
      required this.option,
      required this.date});
}
