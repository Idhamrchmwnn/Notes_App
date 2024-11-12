import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/notes_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('CatatanKu'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text('All Notes'),
            onTap: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .setSelectedCategory('All');
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Work'),
            onTap: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .setSelectedCategory('Work');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Personal'),
            onTap: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .setSelectedCategory('Personal');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Shopping'),
            onTap: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .setSelectedCategory('Shopping');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Ideas'),
            onTap: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .setSelectedCategory('Ideas');
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Archive'),
            onTap: () {
              // TODO: Implement archive view
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_4),
            title: const Text('Theme'),
            trailing: Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return DropdownButton<ThemeMode>(
                  value: themeProvider.themeMode,
                  items: ThemeMode.values.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text(mode.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (mode) {
                    if (mode != null) {
                      themeProvider.toggleTheme(mode);
                    }
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // TODO: Navigate to settings screen
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
