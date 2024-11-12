// File: lib/widgets/note_card.dart
import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/screens/note_detail_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.backgroundColor,
      child: ListTile(
        title: Text(
          note.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.folder, size: 16),
                const SizedBox(width: 4),
                Text(note.category),
                const Spacer(),
                Text(
                  '${note.modifiedAt.day}/${note.modifiedAt.month}/${note.modifiedAt.year}',
                  // style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed(
            NoteDetailScreen.routeName,
            arguments: note,
          );
        },
      ),
    );
  }
}
