import 'package:flutter/material.dart';
import 'package:notes_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.task,
              size: 40,
            ),
          ),
          ListTile(
            onTap: () {
             Navigator.pop(context);
            },
            leading: const Icon(
              Icons.home,
              size: 28,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
            leading: const Icon(
              Icons.settings,
              size: 28,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
