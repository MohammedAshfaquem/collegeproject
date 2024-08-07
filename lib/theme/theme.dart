// import 'package:college_project/theme/themeprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // ignore: must_be_immutable
// class themepage extends StatelessWidget {
//   themepage({super.key, this.showtheme = false});
//   bool showtheme;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//        body: Center(
//           child: TextButton(
//               style: ButtonStyle(
//                   backgroundColor: WidgetStatePropertyAll(
//                       Provider.of<Themeprovider>(context, listen: false).theme
//                           ? Colors.black
//                           : Colors.white)),
//               onPressed: () {
//                 Provider.of<Themeprovider>(context, listen: false)
//                     .toggletheme();
//                 Navigator.maybePop(context);
//                                     Provider.of<Themeprovider>(context, listen: false).changetext();


//               },
//               child: Provider.of<Themeprovider>(context, listen: false).theme
//                   ? Text("Dark", style: TextStyle(color: Colors.white))
//                   : Text(
//                       "Light",
//                       style: TextStyle(color: Colors.black),
//                     ))),
//     );
//   }
// }
