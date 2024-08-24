import 'package:college_project/Donatepage/donatecontroller.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyDonations extends StatelessWidget {
  const MyDonations({super.key});
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              LineAwesomeIcons.angle_left_solid,
            )),
        title: Text(
          'My Donations',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: Theme.of(context).colorScheme.surface),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          color: Colors.red,
          child: ListTile(
            
            title:Text("foodname"),
            subtitle: Text("course"),
          ),
        ),
      ),
    );
  }
}
