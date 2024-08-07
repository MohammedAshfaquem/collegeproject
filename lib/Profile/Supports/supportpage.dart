
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class supportPage extends StatelessWidget {
  supportPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          ' Support',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1,color: Theme.of(context).colorScheme.primary,),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            "lib/images/support.png",
            height: 300,
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Hello! We'Re here to assist you.if you have any question , need quidence, or want to report an issue , our dedicated support team is just a message or call away . We value your experience with our app and strive to provide timely and effective support.Don't hestiate to reach out to us - We're committed to ensuring your satisfaction!.",
                style: TextStyle(fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                 fontSize: 18),
              )),
          ListTile(
            leading: Icon(Icons.email,color: Theme.of(context).colorScheme.primary,),
            title: Text("ashfaquemvkpadi05@gmail.com",style:TextStyle(color: Colors.blue),),
          )
        ],
      ),
    );
  }
}
