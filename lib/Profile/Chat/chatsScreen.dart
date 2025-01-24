import 'package:college_project/Profile/Chat/eachChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        ZIMKit().connectUser(
          id: user.uid,
          name: user.displayName ?? "Unknown",
        );
        print("Zego connected successfully!");
      } else {
        print("User is not authenticated, cannot connect to Zego.");
      }
    } catch (e) {
      print("Error connecting to Zego: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Color(0xff247D7F),
          centerTitle: true,
          title: Text(
            "Chats",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: ZIMKitConversationListView(
          theme: ThemeData(),
          itemBuilder: (context, conversation, defaultWidget) {
            return Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Container(
                  decoration: BoxDecoration(),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: defaultWidget,
                  )),
            );
          },
          
          emptyBuilder: (context, defaultWidget) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 190,
                  ),
                  Container(
                    height: 200,
                    child: Lottie.asset("lib/Animations/emtypage.json",
                        repeat: false, fit: BoxFit.fill),
                  ),
                  Text(
                    "No Data Dound!",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
            );
          },
          lastMessageTimeBuilder: (context, messageTime, defaultWidget) {
            return defaultWidget;
          },
          // lastMessageBuilder: (context, message, defaultWidget) {
          //   return Text(
          //     message!.textContent!.text.toString(),
          //     style: TextStyle(color: Colors.black),
          //   );
          // },
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EachChatScreen(
                    conversationId: conversation.id,
                    conversationName: conversation.name,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
