// File: lib/providers/notes_provider.dart
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  String _selectedCategory = 'All';
  static const String NOTES_KEY = 'notes_data';

  NotesProvider() {
    loadNotes();
  }

  List<Note> get notes {
    if (_selectedCategory == 'All') {
      return [..._notes];
    }
    return _notes.where((note) => note.category == _selectedCategory).toList();
  }

  String get selectedCategory => _selectedCategory;

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString(NOTES_KEY);

    if (notesJson != null) {
      final notesList = json.decode(notesJson) as List<dynamic>;
      _notes = notesList.map((noteMap) {
        return Note(
          id: noteMap['id'],
          title: noteMap['title'],
          content: noteMap['content'],
          createdAt: DateTime.parse(noteMap['createdAt']),
          modifiedAt: DateTime.parse(noteMap['modifiedAt']),
          category: noteMap['category'],
          backgroundColor: Color(noteMap['backgroundColor']),
        );
      }).toList();
      notifyListeners();
    }
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesList = _notes.map((note) {
      return {
        'id': note.id,
        'title': note.title,
        'content': note.content,
        'createdAt': note.createdAt.toIso8601String(),
        'modifiedAt': note.modifiedAt.toIso8601String(),
        'category': note.category,
        'backgroundColor': note.backgroundColor.value,
      };
    }).toList();

    await prefs.setString(NOTES_KEY, json.encode(notesList));
  }

  Future<void> addNote(Note note) async {
    _notes.add(note);
    notifyListeners();
    await _saveNotes();
  }

  Future<void> updateNote(Note updatedNote) async {
    final noteIndex = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = updatedNote;
      notifyListeners();
      await _saveNotes();
    }
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
    await _saveNotes();
  }
}
