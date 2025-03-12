import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  bool _isLoading = false;
  String? imageurl;
   XFile? image;
  File? savedimage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

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
  Future<String> getImage() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    
    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      return data['image'] as String;
    } else {
      // Provide a default image URL
      return "lib/images/avatar.avif"; // Change this to a URL if needed
    }
  }

  Future<void>  updateImage() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String newImageUrl = imageurl ?? await getImage(); // Await the getImage call

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'image': newImageUrl});
FirebaseFirestore.instance
        .collection('Donations')
        .doc(uid)
        .update({'userimage': newImageUrl});
    notifyListeners();
  }
  updateusername(String name) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'name': name});
    notifyListeners();
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

  void clearImageCache() {
    imageurl = null;
    notifyListeners();
  }
}
