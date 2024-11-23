import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constance.dart';
import 'package:notes_app/cubits/add_note_cubit/cubit/notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  Future<void> addNote(NoteModel note, NotesCubit notesCubit) async {
    emit(AddNoteLoading());
    try {
      var notesBox = await _getNotesBox();
      await notesBox.add(note);
      debugPrint("in box ${notesBox.values.last.title}");
      debugPrint("added note to the box is :${note.title}");
      await notesCubit.fetchAllNote(); // تحديث البيانات بعد الإضافة
      emit(AddNoteSuccess());
    } catch (e) {
      print('Error adding note: $e'); // طباعة الخطأ لتشخيصه
      emit(AddNoteFailure(e.toString()));
    }
  }

  Future<Box<NoteModel>> _getNotesBox() async {
    if (!Hive.isBoxOpen(kNotesBox)) {
      return await Hive.openBox<NoteModel>(kNotesBox);
    }
    return Hive.box<NoteModel>(kNotesBox);
  }
}
