import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class Detailspage extends StatelessWidget {
  var itemname;
  var itemdes;
  var user;
  var cntctno;
  var course;
  var imageurl;

  Detailspage(
      {super.key,
      required this.itemname,
      required this.itemdes,
      required this.user,
      required this.cntctno,
      required this.course,
      this.imageurl});

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String fotmatter = DateFormat.yMd().add_jm().format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  child: Image.asset(
                    "lib/images/sadya.jpg",
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)),
                  height: 150,
                  width: 500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: ListTile(
                title: Text('$itemname'),
                subtitle: Text(fotmatter),
                trailing: Text(
                  "free",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$user"),
                      Text("$cntctno"),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "$course",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About details",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("$itemdes"),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 170,
            ),
           
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    Text(
                      '$cntctno',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                                      SizedBox(width: 40,),
        
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: () {
                      FlutterPhoneDirectCaller.callNumber("$cntctno");
                        },
                        child: Text(
                          "call",
                          style: TextStyle(
                              color: Color(0xff247D7F),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ))
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xff247D7F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
