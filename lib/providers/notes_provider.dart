// File: lib/providers/notes_provider.dart
import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<Note> get notes {
    return _notes
        .where((note) =>
            !note.isArchived &&
            (note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                note.content
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase())) &&
            (_selectedCategory == 'All' || note.category == _selectedCategory))
        .toList();
  }

  Future<void> addNote(Note note) async {
    _notes.add(note);
    notifyListeners();
    // TODO: Implement cloud sync
  }

  Future<void> updateNote(Note note) async {
    final noteIndex = _notes.indexWhere((n) => n.id == note.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = note;
      notifyListeners();
      // TODO: Implement cloud sync
    }
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
    // TODO: Implement cloud sync
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
