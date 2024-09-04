import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Registerfield extends StatelessWidget {
  const Registerfield({super.key, required this.controller, required this.hintText, required this.icon, required this.obscuretext});
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscuretext;
  @override
  Widget build(BuildContext context) {
    return   Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      // validator: (value) => value!.length < 3
                      //     ? 'Password should be atleast 3 characters'
                      //     : null,
                      obscureText:obscuretext,
                      controller:controller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          icon,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15).r,
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15).r),
                        hintText:hintText,
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15).r,
                          borderSide:
                              const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  );
  }
}