import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Note {
  String? id;
  final String tittle;
  final String description;
  String? imageBase64;
  Timestamp? createAt;
  Timestamp? uploadAt;

  Note({
    this.id,
    required this.tittle,
    required this.description,
    this.imageBase64,
    this.createAt,
    this.uploadAt,
  });

  factory Note.fromDocument(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
    return Note(
      id: doc.id,
      tittle: data['tittle'], 
      description: data['description'],
      imageBase64: data['imageBase64'],
      createAt: data['createAt'],
      uploadAt: data['uploadAt'],
      );
  }
  Map <String,dynamic> toDocument(){
    return{
      "tittle": tittle,
      "description": description,
      "imageBase64" : imageBase64,
      "createAt" : createAt,
      "uploadAt" : uploadAt,
    };
  }
}
