import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_search_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.title, required this.icon, this.onPressed});
  final String title;
  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: CustomSearchIcon(
            onPressed: onPressed,
            icon: icon,
          ),
        )
      ],
    );
  }
}
