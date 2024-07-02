import 'package:flutter/material.dart';
import 'package:notes_app/components/my_drawer.dart';
import 'package:notes_app/components/notes_tile.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    create();
    super.initState();
  }

  void create() {
    Provider.of<NotesDatabase>(context, listen: false).fetchNotes();
  }

  final TextEditingController t1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: TextField(
                    controller: t1,
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        if (t1.text.isNotEmpty) {
                          Provider.of<NotesDatabase>(context, listen: false)
                              .addNote(t1.text);
                          Navigator.of(context).pop();
                          t1.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Enter the Field"),
                            ),
                          );
                        }
                      },
                      child: const Text("Create"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            Text(
              "Notes",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            NotesTile(),
          ],
        ),
      ),
    );
  }
}
