import 'package:flutter/material.dart';

import 'Notes.dart';

class NotesProviders extends ChangeNotifier {

  //Notes List
  final List<Notes> _notes = [];

 List<Notes> get getNotes{
   return _notes;
 }

// function to add data to list of notes
 void addNotes(String title,String descriptions)
 {
   Notes note = new Notes(title, descriptions);

   _notes.add(note);

    notifyListeners();
 }

 // function to remove or delete notes by using list index position
 void removeNotes(int index)
 {
   _notes.removeAt(index);
   notifyListeners();
 }


}