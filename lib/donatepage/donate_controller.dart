import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Donate extends ChangeNotifier {
  List<ItemModel> _itemlist = [];
  List<ItemModel> get itemlist => _itemlist;
  String _dropdownvalue = 'Free';
  String get dropdownvalue => _dropdownvalue;
  final picker = ImagePicker();
  XFile? image;
  File? savedimage;
  String? imageurl;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
    notifyListeners();
  }

  void addtile(ItemModel itemmodel) {
    _itemlist.add(itemmodel);
    notifyListeners();
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
  Future<void> deleteFieldFromDocument(String docId, String mydonations) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      // Reference to the specific document

      DocumentReference documentRef = _firestore.collection('users').doc(uid);

      // Update the document by deleting the specific field
      await documentRef.update({
        mydonations: FieldValue.delete(),
      });
      notifyListeners();
      print('Field deleted successfully!');
    } catch (e) {
      print('Error deleting field: $e');
    }
  
  }

  
Future<void> deleteDocumentsByUserCondition(String collectionPath, String fieldName) async {
  try {
    // Get the currently signed-in user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the UID of the current user
      String uid = user.uid;

      // Reference to the collection
      CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionPath);

      // Query to find documents where the field matches the user's UID
      QuerySnapshot querySnapshot = await collectionRef.where(fieldName, isEqualTo: uid).get();
    print("valladhum nadakko");
    print(uid);
      // Delete each document that matches the condition
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      print('Documents successfully deleted');
    } else {
      print('No user is currently signed in');
    }
  } catch (e) {
    print('Error deleting documents: $e');
  }
}

}

class ItemModel {
  final String image;
  final String category;
  final String foodname;
  final String description;
  final DateTime date;
  final String lname;
  final String fname;
  final String course;
  final String cntctbo;
  final String option;

  ItemModel({
    required this.image,
    required this.category,
    required this.foodname,
    required this.description,
    required this.date,
    required this.lname,
    required this.fname,
    required this.course,
    required this.cntctbo,
    required this.option,
  });
  final now = DateTime.now();
  // Convert an ItemModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'category': category,
      'foodname': foodname,
      'description': description,
      'date': DateFormat.yMd().add_jm().format(now),
      'lname': lname,
      'fname': fname,
      'course': course,
      'cntctbo': cntctbo,
      'option': option,
    };
  }

  // Convert a Map into an ItemModel
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      image: map['image'],
      category: map['category'],
      foodname: map['foodname'],
      description: map['description'],
      date: DateTime(map['date']),
      lname: map['lname'],
      fname: map['fname'],
      course: map['course'],
      cntctbo: map['cntctbo'],
      option: map['option'],
    );
  }
}
