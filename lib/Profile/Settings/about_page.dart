import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        centerTitle: true,
        title: Text(
          "About",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Title
            Text(
              'Welcome to Mealio!',
             style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff247D7F),
                    fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mealio is a donation app dedicated to fostering a culture of giving within our college community. '
              'Through Mealio, we connect those with extra resources to those in need, ensuring nothing goes to waste '
              'and everyone has access to essential meals.',
            style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16),
            ),
            SizedBox(height: 16.0),
            // Mission Section
            Text(
              'Our Mission',
              style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff247D7F),
                    fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              'At Mealio, our mission is to create a sustainable, compassionate environment where donations '
              'can make a real difference. We aim to reduce food waste and support individuals in our college who '
              'may benefit from a helping hand.',
                 style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16),
            ),
            SizedBox(height: 16.0),
            // How It Works Section
            Text(
              'How It Works',
               style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff247D7F),
                    fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              '1. Donate Meals or Essentials: If you have extra food or essentials, you can easily register them for donation on the app.\n'
              '2. College-Based Impact: All donations stay within our college community, directly benefiting students, staff, or local initiatives.\n'
              '3. Track Your Contributions: Get real-time updates on your donations and see the positive impact you\'re making.',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16),
            ),
            SizedBox(height: 16.0),
            // Why Mealio Section
            Text(
              'Why Mealio?',
             style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff247D7F),
                    fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Convenient & Local: Mealio is specifically designed for our college, ensuring every donation reaches the right hands.\n'
              '• Sustainable Impact: We believe in reducing waste and using resources effectively.\n'
              '• Community First: Build a stronger sense of unity and care within our campus.',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16),
            ),
            SizedBox(height: 16.0),
            // Join Us Section
            Text(
              'Join Us in Making a Difference',
               style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff247D7F),
                    fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              'By using Mealio, you\'re not just donating – you\'re becoming part of a movement that values sustainability, care, and '
              'community well-being. Every small contribution can create a ripple of positive change.',
                 style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16),
            ),
            SizedBox(height: 16.0),
            // Contact Section
            Text(
              'Contact Us',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff247D7F),
                    fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  '📧 Email:',
                  style: TextStyle(fontSize: 16.0, height: 1.5,color: Colors.black),
                ),
                   Text(
                  'Mealio@gmail.com',
                  style: TextStyle(fontSize: 16.0, height: 1.5,color: Colors.blue),
                ),
              ],
            ),
             Row(
              children: [
                Text(
                  '📞 Phone:',
                  style: TextStyle(fontSize: 16.0, height: 1.5,color: Colors.black),
                ),
                   Text(
                  '9946832484',
                  style: TextStyle(fontSize: 16.0, height: 1.5,color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 14.0),
            // Footer
            Center(
              child: Text(
                'Together, we can create a brighter, more connected college community. 🌟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
