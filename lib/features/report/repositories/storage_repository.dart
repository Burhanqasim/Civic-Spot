import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadIssueImage(File imageFile, String issueId) async {
    try {
      final ref = _storage.ref().child("issueImages").child("$issueId.jpg");
      final uploadTask = await ref.putFile(imageFile, SettableMetadata(contentType: 'image/jpeg'));
      return await uploadTask.ref.getDownloadURL();
    } catch(e) {
      return null;
    }
  }

}