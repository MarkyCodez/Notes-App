import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/components/popover.dart';
import 'package:notes_app/database/notes.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class NotesTile extends StatefulWidget {
  const NotesTile({super.key});

  @override
  State<NotesTile> createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
  final TextEditingController t2 = TextEditingController();
  Random random = Random();
  List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.cyanAccent,
    Colors.purpleAccent,
    Colors.lime,
    Colors.indigo,
    Colors.deepPurpleAccent,
    Colors.orange,
    Colors.cyanAccent,
    Colors.purpleAccent,
  ];
  @override
  Widget build(BuildContext context) {
    final List<Notes> current =
        Provider.of<NotesDatabase>(context).currentNotes;
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: current.length,
      itemBuilder: (context, index) {
        final item = current[index];
        final color = colors[random.nextInt(colors.length - 1)];
        return Container(
          height: 70,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
              ),
              title: Text(item.text),
              trailing: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      showPopover(
                        width: 100,
                        height: 100,
                        context: context,
                        bodyBuilder: (context) {
                          return Popover(
                            id: item.id,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.more_vert_outlined),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
