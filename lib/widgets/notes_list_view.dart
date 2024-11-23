import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/add_note_cubit/cubit/notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/custom_note_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        debugPrint("the state is $state");
        if (state is NotesUpdated) {
          debugPrint("new list builder");
          var notes = state.notes;
          debugPrint("in second box in list view ${state.notes.last.title}");
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) => NoteItem(note: notes[index]),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
