import 'package:college_project/listilemodel.dart';
import 'package:college_project/profiepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class myprofilepage extends StatelessWidget {

   myprofilepage({super.key,});
 
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profilepage(),
                  ));
            },
            icon: Icon(
              LineAwesomeIcons.angle_left_solid,
            ),
          ),
          title: Text(
            ' My Profile',
            style: TextStyle(fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
             letterSpacing: 1),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("lib/images/avtar.avif")),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
             
            ],
          ),
        ));
  }
}
