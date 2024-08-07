import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class editprofilemodel extends StatelessWidget {
  const editprofilemodel(
      {super.key,
      required this.hinttext,
      required this.errortext,
      required this.controller,
      required this.icon,
      required this.keyboardType,
      this.obscureText = false,
    });

  final String hinttext;
  final String errortext;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return TextFormField(
      key:_formkey ,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      obscureText:obscureText,
      keyboardType: keyboardType,
      validator: (value) => value!.isEmpty ? errortext : null,
      controller: controller,
      
      decoration: InputDecoration(
        
        disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 255, 14, 14))),
        focusColor: Theme.of(context).colorScheme.primary,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: hinttext,
        hintStyle: TextStyle(color:Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).w,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .primary), // When the field is focused
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color.fromARGB(
                  255, 255, 0, 0)), // When the field is not focused
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.grey), // When the field is not focused
        ),
      ),
    );
  }
}
