import 'package:flutter/material.dart';

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

class CustomSearchIcon extends StatelessWidget {
  const CustomSearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withOpacity(.07),
      ),
      child: Center(
          child: Icon(
        Icons.search,
        size: 26,
      )),
    );
  }
}
