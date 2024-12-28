import 'package:college_project/eachChatScreen.dart';
import 'package:college_project/getUsres.dart';
import 'package:flutter/material.dart';

class FindChats extends StatelessWidget {
  const FindChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Here"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Container(
              child: Text("Find new conatcts"),
            ),
          ),
          StreamBuilder(
            stream: GetUsers.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 450,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return SizedBox(
                  height: 450,
                  child: Center(
                    child: Text(
                      "no users found..!!",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data!.docs[index];
                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text(user['name']),
                    subtitle: Text(user['email']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EachChatScreen(
                            conversationId: user['uid'],
                            conversationName: user['name'],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
