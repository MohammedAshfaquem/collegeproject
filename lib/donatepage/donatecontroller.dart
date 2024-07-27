import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class Donatecontroler extends ChangeNotifier {
  List<Itemmodel> _itemlist = [];
  List<Itemmodel> get itemlist => _itemlist;
  String _dropdownvalue = 'Free';
  String get dropdownvalue => _dropdownvalue;
  final picker = ImagePicker();
  File? image;
  File? savedimage;
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
  String get email=>_email;
  String _editname = '';
  String get eeditname=>_editname;
  

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
    savedimage = null;
    notifyListeners();
  }

  void editprofile(String name,String email){
   _email = email;
   _editname= name;
   notifyListeners();
  }

  void showimagepicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          
          
           content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    imagefromgallery();
                    Navigator.of(context).pop();
                    notifyListeners();
                  },
                  child: Container(
                    height: 180.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                        color: Color(0xff247D7F),
                        borderRadius: BorderRadius.circular(22)),
                    
                    child: Column(
                      children: [
                        Image.asset(
                          'lib/images/gallery.png',
                          height: 150.h,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    imagefromcamera();
                    Navigator.of(context).pop();
                    notifyListeners();
                  },
                  child: Container(
                    height: 180.h,
                     width: 130.w,
                    decoration: BoxDecoration(
                        color: Color(0xff247D7F),
                        borderRadius: BorderRadius.circular(22)),
                   
                    child: Column(
                      children: [
                        Image.asset(
                          'lib/images/camera.png',
                          height: 150.h,
                        ),
                        Text(
                          "Camera",
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
        );
      },
    );
  }

  imagefromgallery() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      image = File(PickedFile.path);
      savedimage = image;
    } else {
      print("no image picked");
    }
    notifyListeners();
    //  if (value != null) {
    //    _cropimage(File(value.path));
    // }
  }

  imagefromcamera() async {
    final PickedFile = await picker.pickImage(source: ImageSource.camera);

    if (PickedFile != null) {
      image = File(PickedFile.path);
      savedimage = image;
    } else {
      print("no image picked");
    }
    notifyListeners();
  }
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
