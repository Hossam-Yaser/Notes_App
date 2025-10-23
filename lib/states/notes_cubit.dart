import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/models/note.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
    emit(NotesLoaded(List.from(notes)));
  }

  void deleteNoteAt(int index) {
    notes.removeAt(index);
    emit(notes.isEmpty ? NotesInitial() : NotesLoaded(List.from(notes)));
  }

  void updateNoteAt(int index, Note updatedNote) {
    notes[index] = updatedNote;
    emit(NotesLoaded(List.from(notes)));
  }

  void loadNotes() {
    emit(notes.isEmpty ? NotesInitial() : NotesLoaded(List.from(notes)));
  }

  void reorderNotes(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1; // adjust index after item removal

    final note = notes.removeAt(oldIndex);
    notes.insert(newIndex, note);

    emit(NotesLoaded(List.from(notes)));
  }
}
