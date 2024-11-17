import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constance.dart';
import 'package:notes_app/model/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  addNote(NoteModel note) async {
    emit(AddNoteLoading());
    try {
      var notesBox = await _getNotesBox();
      await notesBox.add(note);
      emit(AddNoteSuccess());
    } catch (e) {
      print('Error adding note: $e'); // طباعة الخطأ لمساعدتك في تحديد السبب
      emit(AddNoteFailure(e.toString()));
    }
  }

  // نقل دالة _getNotesBox هنا لتكون مستقلة
  Future<Box<NoteModel>> _getNotesBox() async {
    if (!Hive.isBoxOpen(kNotesBox)) {
      return await Hive.openBox<NoteModel>(
          kNotesBox); // افتح الـ Box فقط إذا لم يكن مفتوحًا
    }
    return Hive.box<NoteModel>(kNotesBox); // استخدم الـ Box الموجود
  }
}
