import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  /// Add a new diary entry
  Future<void> addEntry(String title, String text, String icon) async {
    final userEmail = FirebaseAuth.instance.currentUser!.email!;
    final date = DateTime.now();

    await _db
        .collection("notes")
        .doc(uid)
        .collection("notes")
        .add({
          "title": title,
          "text": text,
          "icon": icon,
          "useremail": userEmail,
          "date": date,
        });
  }

  /// Read all entries
  Stream<QuerySnapshot> getEntries() {
    return _db
        .collection("notes")
        .doc(uid)
        .collection("notes")
        .orderBy("date", descending: true)
        .snapshots();
  }

  /// Delete an entry
  Future<void> deleteEntry(String entryId) async {
    await _db
        .collection("notes")
        .doc(uid)
        .collection("notes")
        .doc(entryId)
        .delete();
  }
}
