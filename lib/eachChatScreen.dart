import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class EachChatScreen extends StatefulWidget {
  const EachChatScreen(
      {super.key,
      required this.conversationId,
      required this.conversationName});
  final String conversationId;
  final String conversationName;

  @override
  State<EachChatScreen> createState() => _EachChatScreenState();
}

class _EachChatScreenState extends State<EachChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
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
      child: ZIMKitMessageListPage(
        conversationID: widget.conversationId,
        conversationType: ZIMConversationType.peer,
        appBarBuilder: (context, defaultAppBar) {
          return AppBar(
            title: defaultAppBar.title,
            leading: defaultAppBar.leading,
            flexibleSpace: defaultAppBar.flexibleSpace,
            backgroundColor: Color.fromARGB(255, 50, 170, 172),
          );
        },
        messageListLoadingBuilder: (context, defaultWidget) {
          return Container(
            child: defaultWidget,
            height: 200,
            width: 100,
          );
        },
        messageListErrorBuilder: (context, defaultWidget) {
          return Container(
            child: defaultWidget,
            height: 200,
            width: 100,
          );
        },
        theme: ThemeData.light(
          useMaterial3: false,
        ),
        showMoreButton: false,
        showRecordButton: false,
        showPickFileButton: true,
        inputBackgroundDecoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(33)),
        inputDecoration: InputDecoration(
            hintText: "Send a message...",
            hintStyle: TextStyle(color: Colors.black)),
        messageInputContainerPadding: EdgeInsets.symmetric(horizontal: 20),
        messageInputHeight: 70,
        messageItemBuilder: (context, message, defaultWidget) {
          return Padding(
              padding: EdgeInsets.only(
                top: 6,
                right: 10,
                left: 15,
              ),
              child: defaultWidget);
        },
        pickFileButtonWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            Icons.file_download,
            color: Colors.black,
          ),
        ),
        pickMediaButtonWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            CupertinoIcons.photo_on_rectangle,
            color: Colors.black,
          ),
        ),
        sendButtonWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            CupertinoIcons.paperplane,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
