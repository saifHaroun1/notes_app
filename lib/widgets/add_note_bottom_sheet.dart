import 'package:flutter/material.dart';
import 'package:notes_app/constance.dart';
import 'package:notes_app/widgets/custom_bottom.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            CustomTextField(
              hint: "title",
            ),
            SizedBox(
              height: 16,
            ),
            CustomTextField(
              hint: "content",
              maxLines: 4,
            ),
            SizedBox(
              height: 50,
            ),
            customButton(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
