import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot entry;
  const EntryDetailsPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(entry['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(entry['text']),
      ),
    );
  }
}
