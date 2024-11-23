import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constance.dart';
import 'package:notes_app/model/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel> notes = [];

  Future<void> fetchAllNote() async {
    emit(NotesLoading()); // إظهار حالة التحميل
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      debugPrint("in second box ${notesBox.values.last.title}");

      notes = notesBox.isEmpty ? [] : notesBox.values.toList();
      debugPrint("in second box after convert ${notes.last.title}");

      // تأكد من أن البيانات تغيرت قبل إرسال الحالة
      if (state is! NotesUpdated ||
          (state is NotesUpdated && (state as NotesUpdated).notes != notes)) {
        debugPrint("we are updating in box in state");
        emit(NotesUpdated(notes)); // إرسال الحالة فقط إذا كانت البيانات جديدة
      }
    } catch (e) {
      emit(NotesError("Failed to load notes")); // إذا حدث خطأ في جلب الملاحظات
    }
  }
}
