import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SupportPage extends StatelessWidget {
  SupportPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        centerTitle: true,
        title: Text(
          "Support",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
         leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            
            LineAwesomeIcons.angle_left_solid,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          Image.asset(
            "lib/images/support.png",
            height: 300,
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Hello! We'Re here to assist you.if you have any question , need quidence, or want to report an issue , our dedicated support team is just a message or call away . We value your experience with our app and strive to provide timely and effective support.Don't hestiate to reach out to us - We're committed to ensuring your satisfaction!.",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18),
              )),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "ashfaquemvkpadi05@gmail.com",
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
