import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Donate extends ChangeNotifier {
  bool _isLoading = false;
  // other properties...

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
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

  Future<void> imagepickcamera() async {
    setLoading(true);
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) {
      setLoading(false);
      return;
    }

    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);

    try {
      await referenceimagetoupload.putFile(File(file.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
    } catch (e) {
      print("error:$e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> imagepickgallery() async {
    setLoading(true);
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      setLoading(false);
      return;
    }

    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);

    try {
      await referenceimagetoupload.putFile(File(file.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
    } catch (e) {
      print("error:$e");
    } finally {
      setLoading(false);
    }
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
  void reset(){
    currentvalue = null;
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

  Future<void> deleteFromMyDonations(int index) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      // Reference to the specific document
      DocumentReference documentRef = _firestore.collection('users').doc(uid);

      // Use a transaction to ensure data consistency
      await _firestore.runTransaction((transaction) async {
        // Get the current document snapshot
        DocumentSnapshot docSnapshot = await transaction.get(documentRef);

        // Check if the document exists
        if (!docSnapshot.exists) {
          throw Exception('Document does not exist');
        }

        // Get the current list of donations
        List<dynamic> donationsList =
            docSnapshot.get('mydonations') as List<dynamic>;

        // Ensure the index is within bounds
        if (index < 0 || index >= donationsList.length) {
          throw Exception('Index out of bounds');
        }

        // Remove the item at the specified index
        donationsList.removeAt(index);

        // Update the document with the new list
        transaction.update(documentRef, {'mydonations': donationsList});
      });

      notifyListeners();
      print('Item deleted successfully!');
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> deleteFromAvailbleDanations(
      String collectionPath, String fieldName,int index,String donationId) async {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the UID of the current user
        String uid = user.uid;

        // Reference to the collection
        CollectionReference collectionRef =
            FirebaseFirestore.instance.collection(collectionPath);

        // Query to find documents where the field matches the user's UID
        QuerySnapshot querySnapshot =
            await collectionRef.where(fieldName, isEqualTo: donationId).get();
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
  final String donationId;
  final String quantity;

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
    required this.donationId,
    required this.quantity, 
  });
  final now = DateTime.now();
  // Convert an ItemModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'category': category,
      'foodname': foodname,
      'description': description,
      'date': DateFormat.jm().format(now),
      'lname': lname,
      'fname': fname,
      'course': course,
      'cntctbo': cntctbo,
      'option': option,
      'donationid':donationId,
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
      donationId:map["donationid"],
      quantity:map['quantity']
    );
  }
}
