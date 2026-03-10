import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/firestore_service.dart';

final userProgressProvider = StreamProvider((ref) {
  return ref.watch(firestoreServiceProvider).getUserProgress();
});