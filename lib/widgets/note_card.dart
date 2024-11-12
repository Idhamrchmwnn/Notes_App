// File: lib/widgets/note_card.dart
import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:notesapp/screens/note_detail_screen.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content:
            Text('Apakah Anda yakin ingin menghapus catatan "${note.title}"?'),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .deleteNote(note.id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

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
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteConfirmation(context),
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
