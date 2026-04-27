import 'package:civicspot/features/home/model/issue_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class IssueRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get IssuseModel => null;

  // Stream all issues
  Stream<List<IssueModel>> getIssuesstream(){
    return _firestore.collection("issues").
    orderBy("createdAt", descending: true).
    snapshots().
    map((snapshot) => snapshot.docs.map((doc) => IssueModel.fromJson(doc.data(), doc.id)).toList());
  }
  // Add issue
  Future<void> addIssue(IssueModel issue) async {
    await _firestore.collection("issues").add(issue.toJson());
  }
}