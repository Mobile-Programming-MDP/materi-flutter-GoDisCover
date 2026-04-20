import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;
  const NoteDialog({super.key, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _tittleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _tittleController.text = widget.note!.tittle;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null ? 'Add Notes' : 'Update Notes'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Title', textAlign: TextAlign.start),
          TextField(controller: _tittleController),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('Description'),
          ),
          TextField(controller: _descriptionController, maxLines: null),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('Image: '),
          ),
          Expanded(
            child: _imageFile != null
                ? Image.file(_imageFile!, fit: BoxFit.cover)
                : (widget.note?.imageUrl != null && 
                        Uri.parse(widget.note!.imageurl!,fit: BoxFit.cover) : Container()),
          ),
        ],
      ),
      actions: [],
    );
  }
}
