import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/add_edit_screen.dart';
import 'package:notes_app/states/notes_cubit.dart';
import 'package:notes_app/states/notes_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesInitial) {
            return Center(
              child: Text(
                'Welcome to Notes App\nClick + to add a new note',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Colors.grey[700]),
              ),
            );
          } else if (state is NotesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReorderableListView.builder(
                buildDefaultDragHandles: false,
                padding: const EdgeInsets.only(
                  bottom: 80,
                ), // to avoid overlap with FAB
                itemCount: state.notes.length,
                onReorder: (oldIndex, newIndex) {
                  // 🔹 Trigger Cubit function
                  context.read<NotesCubit>().reorderNotes(oldIndex, newIndex);
                },
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return GestureDetector(
                    key: ValueKey(note),
                    //  Required for ReorderableListView
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddEditScreen(existingNote: note, index: index),
                        ),
                      );
                    },
                    child: Card(
                      shadowColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      surfaceTintColor: Colors.cyan,
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        key: ValueKey(note),
                        title: Text(
                          note.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(note.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<NotesCubit>().deleteNoteAt(index);
                              },
                            ),
                            ReorderableDragStartListener(
                              index: index,
                              child: Icon(Icons.drag_handle),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'Add/EditScreen');
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
    );
  }
}
