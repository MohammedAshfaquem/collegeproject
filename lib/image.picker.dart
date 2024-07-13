import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class gallerypage extends StatefulWidget {
  const gallerypage({super.key});

  @override
  State<gallerypage> createState() => _gallerypageState();
}

class _gallerypageState extends State<gallerypage> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            imageFile == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                        radius: 50,
                        child: Image.asset("lib/images/images.png",fit: BoxFit.cover,)),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.black)),
                onPressed: () async {
                  Map<Permission, PermissionStatus> status = await [
                    Permission.storage,
                    Permission.camera,
                  ].request();
                  if (status[Permission.storage]!.isGranted &&
                      status[Permission.camera]!.isGranted) {
                    showimagepicker(context);
                  } else {
                    Text("no permisiion granted");
                  }
                },
                child: Text(
                  "Take Image",
                  style: TextStyle(color: Colors.white),
                )),
                SizedBox(height: 10,)
          ],
        );
  }

  final picker = ImagePicker();
  void showimagepicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Card(
          child: Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    imagefromgallery();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.browse_gallery),
                ),
                IconButton(
                  onPressed: () {
                    imagefromcamera();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.camera),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  imagefromgallery() async {
    await picker
        .pickImage(source: ImageSource.gallery)
        .then((value) => setState(() {
              imageFile = File(value!.path);
            }));

      //if (value != null) {
        //_cropimage(File(value.path));
   //  }
  }

  imagefromcamera() async {
    await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(imagefromcamera().path);
    });
  
  }

 /*_cropimage(File imgfile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgfile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image cropper",
              lockAspectRatio: false,
              toolbarWidgetColor: Colors.white,
              toolbarColor: Colors.orange,
              initAspectRatio: CropAspectRatioPreset.original),
          IOSUiSettings(title: 'imagecropper')
        ]);
    
  }*/
}