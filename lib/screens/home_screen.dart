// File: lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:notesapp/screens/note_detail_screen.dart';
import 'package:notesapp/widgets/app_drawer.dart';
import 'package:notesapp/widgets/note_card.dart';
import 'package:notesapp/widgets/note_search_delegate.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatatanKu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NoteSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sorting options
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final notes = notesProvider.notes;
          return notes.isEmpty
              ? const Center(
                  child: Text('No notes yet. Start creating!'),
                )
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return NoteCard(note: notes[index]);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NoteDetailScreen.routeName);
        },
      ),
    );
  }
}
