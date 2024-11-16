import 'package:flutter/material.dart';
import 'package:notes_app/constance.dart';

class customButton extends StatelessWidget {
  const customButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
          color: KPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Center(
          child: Text(
        "Save",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      )),
    );
  }
}