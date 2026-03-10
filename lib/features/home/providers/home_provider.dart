import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/firestore_service.dart';

final subjectsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return ref.read(firestoreServiceProvider).getSubjects();
});

final popularVideosProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return ref.read(firestoreServiceProvider).getPopularVideos();
});