import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/states/notes_cubit.dart';
import 'package:notes_app/widgets/custom_textfield.dart';

class AddEditScreen extends StatelessWidget {
  final Note? existingNote;
  final int? index;

  AddEditScreen({super.key, this.existingNote, this.index});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 🔹 Pre-fill if editing
    if (existingNote != null) {
      titleController.text = existingNote!.title;
      descriptionController.text = existingNote!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          existingNote == null ? 'Add Note' : 'Edit Note',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.cyan,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextfield(
              labelText: "Title",
              hintText: "Enter Note Title",
              controller: titleController,
            ),
            const SizedBox(height: 20),
            CustomTextfield(
              labelText: "Description",
              hintText: "Enter Note Description",
              controller: descriptionController,
              maxLines: 4,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final title = titleController.text.trim();
          final description = descriptionController.text.trim();

          if (title.isEmpty || description.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill in both fields"),
                backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }

          final note = Note(title: title, description: description);

          if (existingNote == null) {
            //  Add new
            context.read<NotesCubit>().addNote(note);
          } else {
            //  Update existing
            context.read<NotesCubit>().updateNoteAt(index!, note);
          }

          Navigator.pop(context);
        },
        backgroundColor: Colors.cyan,
        label: Text(
          existingNote == null ? "Save" : "Update",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
