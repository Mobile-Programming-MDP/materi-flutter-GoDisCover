import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:path/path.dart' as path;

class NoteService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection = _database.collection(
    'notes',
  );

  static Future<void> addNote(Note note) async {
    Map<String, dynamic> newNote = {
      'tittle': note.tittle,
      "description": note.description,
      "image_url": note.imageBase64,
      'latitude': note.latitude,
      'longitude': note.longitude,
      "createAt": FieldValue.serverTimestamp(),
      "uploadAt": FieldValue.serverTimestamp(),
    };
    await _notesCollection.add(newNote);
  }

  static Stream<List<Note>> getNoteList() {
    return _notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          tittle: data['tittle'],
          description: data['description'],
          imageBase64: data['imageurl'],
          latitude: data['latitude'],
          longitude: data['longitude'],
          createAt: data['createdAt'] != null
              ? data['createdAt'] as Timestamp
              : null,
          uploadAt: data['uploadAt'] != null
              ? data['uploadAt'] as Timestamp
              : null,
        );
      }).toList();
    });
  }

  static Future<void> updateNote(Note note) async {
    Map<String, dynamic> updateNote = {
      'tittle': note.tittle,
      'description': note.description,
      'imageurl': note.imageBase64,
      'latitude': note.latitude,
      'longitude': note.longitude,
      'createAt': note.createAt,
      'updateAt': FieldValue.serverTimestamp(),
    };
    await _notesCollection.doc(note.id).update(updateNote);
  }

  static Future<void> deleteNote(Note note) async {
    await _notesCollection.doc(note.id).delete();
  }
}
