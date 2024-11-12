// File: lib/models/note.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class Note {
  final String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime modifiedAt;
  String category;
  Color backgroundColor;
  List<String> tags;
  bool isArchived;
  bool isPinned;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
    this.category = 'Uncategorized',
    this.backgroundColor = Colors.white,
    this.tags = const [],
    this.isArchived = false,
    this.isPinned = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      'category': category,
      'backgroundColor': backgroundColor.value,
      'tags': tags,
      'isArchived': isArchived,
      'isPinned': isPinned,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
      modifiedAt: DateTime.parse(map['modifiedAt']),
      category: map['category'],
      backgroundColor: Color(map['backgroundColor']),
      tags: List<String>.from(map['tags']),
      isArchived: map['isArchived'],
      isPinned: map['isPinned'],
    );
  }
}
