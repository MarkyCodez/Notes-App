import 'package:flutter/material.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:provider/provider.dart';

class Popover extends StatefulWidget {
  final int id;
  const Popover({super.key, required this.id});

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  final TextEditingController t1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 35,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    height: 150,
                    color: Theme.of(context).colorScheme.primary,
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: t1,
                            decoration: const InputDecoration(
                              labelText: "Update",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              hintText: "Enter",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (t1.text.isNotEmpty) {
                                Provider.of<NotesDatabase>(context,
                                        listen: false)
                                    .updateNote(widget.id, t1.text);
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please Enter the Field"),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary,
                              foregroundColor: Theme.of(context).colorScheme.primary,
                            ),
                            child: const Text("Update"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Text(
              "Edit",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 35,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
          child: TextButton(
            onPressed: () {
              Provider.of<NotesDatabase>(context, listen: false)
                  .deleteNotes(widget.id);
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
