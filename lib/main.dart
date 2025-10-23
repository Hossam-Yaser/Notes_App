import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/add_edit_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/states/notes_cubit.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'HomeScreen': (context) => HomeScreen(),
          'Add/EditScreen': (context) => AddEditScreen(),
        },
        initialRoute: 'HomeScreen',
      ),
    );
  }
}
