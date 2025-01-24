import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FAQsPage extends StatelessWidget {
  final List<FAQ> faqList = [
    FAQ(
      question: 'What is Mealio?',
      answer: 'Mealio is a donation app designed specifically for our college community. It allows users to donate meals and essentials to help others within the campus.',
    ),
    FAQ(
      question: 'Who can use Mealio?',
      answer: 'Mealio is exclusively for students, staff, and other members of our college.',
    ),
    FAQ(
      question: 'How do I make a donation?',
      answer: 'To make a donation, click on the "Donate" button, fill in the required details (such as item description and availability), and submit.',
    ),
    FAQ(
      question: 'What types of donations are accepted?',
      answer: 'Mealio accepts food items, non-perishable goods, and essentials that can benefit individuals in the college community.',
    ),
    FAQ(
      question: 'Can I donate money through Mealio?',
      answer: 'No, Mealio focuses on physical donations like meals and essentials. Monetary donations are not supported.',
    ),
    FAQ(
      question: 'How are donations distributed?',
      answer: 'Donations are distributed within the college through verified collection points or directly to those in need via campus organizations.',
    ),
    FAQ(
      question: 'What should I do if I forget my password?',
      answer: 'Use the "Forgot Password" option on the login page to reset your password.',
    ),
    FAQ(
      question: 'Is my personal information safe on Mealio?',
      answer: 'Yes, Mealio ensures that your data is secure and only used for app-related purposes.',
    ),
     FAQ(
      question: 'Can I cancel a donation after submitting it?',
      answer: 'Yes, you can cancel a donation if it hasn’t been processed yet. Go to the “My Donations” section,here you can see all your donations , select the donation you wish to cancel, and tap on the “Cancel Donation” option.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        centerTitle: true,
        title: Text(
          "FAQs",
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
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ExpansionTile(
              collapsedIconColor: Colors.black,
              title: Text(
                faqList[index].question,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faqList[index].answer,
                    style: TextStyle(fontSize: 16.0, height: 1.5,color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}
