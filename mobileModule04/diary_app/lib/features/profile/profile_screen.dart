import 'package:diary_app/features/profile/entry_details_page.dart';
import 'package:diary_app/features/profile/entry_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/services/diary_service.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final DiaryService _service = DiaryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Diary"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => EntryPage())
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _service.getEntries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("No diary entries yet 💭"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];
              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['date'].toDate().toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _service.deleteEntry(data.id),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              EntryDetailsPage(entry: data)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
