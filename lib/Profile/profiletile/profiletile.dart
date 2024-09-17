import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePageModel extends StatelessWidget {
  const ProfilePageModel(
      {super.key,
      required this.onTap,
      required this.text,
      this.listtilecolor = const Color(0xff247D7F),
      required this.icon,
      this.colors = Colors.white});
  final String text;
  final IconData icon;
  final Color colors;
  final Color listtilecolor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: listtilecolor,
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                100,
              ),
              color: Theme.of(context).colorScheme.surface),
          height: 40,
          width: 40,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
              color: colors, fontWeight: FontWeight.w700, fontSize: 17),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              100,
            ),
            color: Theme.of(context).colorScheme.surface,
          ),
          height: 40,
          width: 40,
          child: Icon(
            LineAwesomeIcons.angle_right_solid,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
