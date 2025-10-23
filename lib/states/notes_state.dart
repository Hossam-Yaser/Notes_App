import 'package:notes_app/models/note.dart';

abstract class NotesState {
  const NotesState();

  List<Object?> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;

  const NotesLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}
