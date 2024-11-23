part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesUpdated extends NotesState {
  List<NoteModel> notes;

  NotesUpdated(this.notes);
}

class NotesError extends NotesState {
  final String message;

  NotesError(this.message);
}
