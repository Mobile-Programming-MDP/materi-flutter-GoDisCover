import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Note {
  String? id;
  final String tittle;
  final String description;
  String? imageBase64;
  String? latitude;
  String? longitude;
  Timestamp? createAt;
  Timestamp? uploadAt;

  Note({
    this.id,
    required this.tittle,
    required this.description,
    this.imageBase64,
    this.latitude,
    this.longitude,
    this.createAt,
    this.uploadAt,
  });

  factory Note.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      tittle: data['tittle'],
      description: data['description'],
      imageBase64: data['imageBase64'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      createAt: data['createAt'],
      uploadAt: data['uploadAt'],
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "tittle": tittle,
      "description": description,
      "imageBase64": imageBase64,
      "latitude": latitude,
      "longitude": longitude,
      "createAt": createAt,
      "uploadAt": uploadAt,
    };
  }
}
