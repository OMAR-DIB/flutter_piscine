import 'package:flutter/material.dart';
import 'package:diary_app/services/diary_service.dart';

class EntryPage extends StatelessWidget {
  EntryPage({super.key});

  final titleController = TextEditingController();
  final textController = TextEditingController();
  final iconController = TextEditingController();
  final DiaryService _service = DiaryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Diary Entry")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: iconController, decoration: const InputDecoration(labelText: "Feeling (icon)")),
            TextField(controller: textController, decoration: const InputDecoration(labelText: "What happened today?"), maxLines: 5),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _service.addEntry(
                    titleController.text,
                    textController.text,
                    iconController.text);
                Navigator.pop(context); // return to list
              },
              child: const Text("Save Entry"),
            )
          ],
        ),
      ),
    );
  }
}
