import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // استيراد المكتبة
import 'package:notes_app/constance.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/custom_bottom.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery هنا مباشرة سيكون آمنًا
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocBuilder<AddNoteCubit, AddNoteState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // استخدام MediaQuery هنا ضمن build
            ),
            child: SingleChildScrollView(child: AddNoteForm()),
          );
        },
      ),
    );
  }
}

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subTitle;
  double bottomInset = 0; // سنقوم بتخزين قيمة الـ bottomInset هنا

  @override
  Widget build(BuildContext context) {
    // تأجيل الوصول إلى MediaQuery بعد بناء الشجرة باستخدام addPostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newBottomInset = MediaQuery.of(context).viewInsets.bottom;
      if (newBottomInset != bottomInset) {
        setState(() {
          bottomInset = newBottomInset; // تحديث الـ state بالقيمة الجديدة
        });
      }
    });

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
            hint: "title",
          ),
          const SizedBox(height: 16),
          CustomTextField(
            onSaved: (value) {
              subTitle = value;
            },
            hint: "content",
            maxLines: 4,
          ),
          const SizedBox(height: 50),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return customButton(
                isLoading: state is AddNoteLoading,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var noteModel = NoteModel(
                      title: title!,
                      subTitle: subTitle!,
                      date: DateTime.now().toString(),
                      color: Colors.blue.value,
                    );
                    BlocProvider.of<AddNoteCubit>(context)
                        .addNote(noteModel)
                        .then((_) {
                      Navigator.pop(
                          context); // إغلاق الـ BottomSheet بعد إضافة الملاحظة
                    });
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
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
