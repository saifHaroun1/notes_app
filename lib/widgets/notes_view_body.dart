import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/custom_note_item.dart';
import 'package:notes_app/widgets/notes_list_view.dart';

class NotesViewBody extends StatelessWidget {
  const NotesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // تثبيت الـ AppBar أثناء التمرير
            backgroundColor: Theme.of(context)
                .appBarTheme
                .backgroundColor, // نفس لون الـ AppBar
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Notes"),
              background: Container(
                color: Theme.of(context)
                    .appBarTheme
                    .backgroundColor, // نفس اللون خلفية
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // هنا تضع المكونات التي تريد أن تظهر أسفل الـ AppBar عند التمرير
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: NotesListView(), // استخدم قائمة الملاحظات الخاصة بك
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
