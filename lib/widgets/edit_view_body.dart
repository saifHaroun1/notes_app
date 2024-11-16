import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/custom_search_icon.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class EditNoteViewBody extends StatelessWidget {
  const EditNoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CustomAppBar(
            icon: Icons.check,
            title: "Edit Note",
          ),
          SizedBox(
            height: 16,
          ),
          CustomTextField(hint: "title"),
          SizedBox(
            height: 16,
          ),
          CustomTextField(
            hint: "content",
            maxLines: 5,
          )
        ],
      ),
    );
  }
}
