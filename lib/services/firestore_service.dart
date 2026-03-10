import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreServiceProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser!.uid;

  // Save user profile after signup
  Future<void> saveUserProfile({
    required String fullName,
    required String email,
    required String className,
  }) async {
    await _db.collection('users').doc(userId).set({
      'fullName': fullName,
      'email': email,
      'class': className,
      'createdAt': FieldValue.serverTimestamp(),
      'avatar': '',
    });
  }

  // Get user profile
  Stream<DocumentSnapshot> getUserProfile() {
    return _db.collection('users').doc(userId).snapshots();
  }

  // Get all subjects
  Future<List<Map<String, dynamic>>> getSubjects() async {
    final snapshot = await _db.collection('subjects').get();
    return snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  // Get popular videos
  Future<List<Map<String, dynamic>>> getPopularVideos() async {
    final snapshot = await _db
        .collection('videos')
        .orderBy('views', descending: true)
        .limit(5)
        .get();
    return snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  // Get user progress per subject
  Stream<QuerySnapshot> getUserProgress() {
    return _db
        .collection('users')
        .doc(userId)
        .collection('progress')
        .snapshots();
  }
}