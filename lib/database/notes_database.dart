import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/database/notes.dart';
import 'package:path_provider/path_provider.dart';

class NotesDatabase extends ChangeNotifier{
  static late Isar isar;
  //Initialization
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NotesSchema], directory: dir.path);
  }

  final List<Notes> currentNotes = [];

  //Read
  Future<void> addNote(String textFromUser) async {
    final newNote = Notes()..text = textFromUser;
    await isar.writeTxn(
      () => isar.notes.put(newNote),
    );
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Notes> fetch = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetch);
    notifyListeners();
  }

  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  Future<void> deleteNotes(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
