import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/cubits/add_note_cubit/cubit/notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/colors_list_view.dart';
import 'package:notes_app/widgets/custom_bottom.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final notesCubit = context
        .read<NotesCubit>(); // استخدم context.read() بدلاً من BlocProvider.of()

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: AddNoteForm(notesCubit: notesCubit),
      ),
    );
  }
}

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key, required this.notesCubit});

  final NotesCubit notesCubit;

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          const SizedBox(height: 32),
          CustomTextField(
            onSaved: (value) {
              title = value;
            },
            hint: "Title",
          ),
          const SizedBox(height: 16),
          CustomTextField(
            onSaved: (value) {
              subTitle = value;
            },
            hint: "Content",
            maxLines: 4,
          ),
          SizedBox(height: 16),
          ColorListView(),
          const SizedBox(height: 50),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return customButton(
                isLoading: state is AddNoteLoading,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    String formattedDate =
                        DateTime.now().toString().substring(0, 10);
                    var noteModel = NoteModel(
                      title: title!,
                      subTitle: subTitle!,
                      date: formattedDate,
                      color: Colors.blue.value,
                    );

                    // إضافة الملاحظة باستخدام AddNoteCubit
                    context
                        .read<AddNoteCubit>()
                        .addNote(noteModel, widget.notesCubit)
                        .then((_) {
                      // بعد إضافة الملاحظة، تحديث الملاحظات في NotesCubit
                      widget.notesCubit.fetchAllNote();
                    });

                    // BlocProvider.of<AddNoteCubit>(context)
                    //     .addNote(noteModel, widget.notesCubit)
                    //     .then((_) {
                    //   // بعد إضافة الملاحظة، تحديث الملاحظات في NotesCubit
                    //   widget.notesCubit.fetchAllNote();
                    // });

                    // إغلاق الـ bottom sheet بعد إضافة الملاحظة
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
