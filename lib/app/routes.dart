import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_performance_tracker/features/subjects/screens/subject_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/reports/screens/reports_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/subjects/screens/subjects_screen.dart';
import '../features/subjects/screens/subject_detail_screen.dart';
import '../features/quiz/screens/quiz_screen.dart';
import '../features/video/screens/video_screen.dart';
import '../features/splash/screens/splash_screen.dart';
import '../services/auth_service.dart';
import '../features/profile/screens/edit_profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isSplash = state.matchedLocation == '/';
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      // Never redirect splash screen
      if (isSplash) return null;

      if (isLoggedIn && isAuthRoute) return '/home';
      if (!isLoggedIn && !isAuthRoute) return '/login';
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: '/subjects',
        builder: (context, state) => const SubjectsScreen(),
      ),
      GoRoute(
        path: '/subject/:name',
        builder: (context, state) => SubjectDetailScreen(
          subjectName: state.pathParameters['name'] ?? 'Subject',
        ),
      ),
      GoRoute(
        path: '/quiz/:subject',
        builder: (context, state) => QuizScreen(
          subjectName: state.pathParameters['subject'] ?? 'General',
        ),
      ),
      GoRoute(
        path: '/video/:subject/:chapter',
        builder: (context, state) => VideoScreen(
          subjectName: state.pathParameters['subject'] ?? 'Subject',
          chapterName: state.pathParameters['chapter'] ?? 'Chapter',
        ),
      ),
      
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});