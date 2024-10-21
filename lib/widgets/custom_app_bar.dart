import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_search_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 0),
          child: Text(
            "Notes",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: CustomSearchIcon(),
        )
      ],
    );
  }
}
