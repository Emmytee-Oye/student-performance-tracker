import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';
import '../../../services/auth_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;

    final subjects = [
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'color': const Color(0xFFFF5733)},
      {'name': 'Physics', 'icon': Icons.science_rounded, 'color': const Color(0xFF4CAF50)},
      {'name': 'Chemistry', 'icon': Icons.biotech_rounded, 'color': const Color(0xFF2196F3)},
      {'name': 'Biology', 'icon': Icons.eco_rounded, 'color': const Color(0xFF9C27B0)},
      {'name': 'Reasoning', 'icon': Icons.psychology_rounded, 'color': const Color(0xFFFF9800)},
      {'name': 'Social Science', 'icon': Icons.public_rounded, 'color': const Color(0xFF00BCD4)},
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFF5733), Color(0xFFFF8C00)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.person_rounded,
                                  color: AppTheme.primaryColor),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Hi, ${user?.displayName?.split(' ').first ?? 'Student'} 👋',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'What would you learn today?',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.notifications_outlined,
                              color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded,
                            color: AppTheme.textGrey),
                        const SizedBox(width: 12),
                        Text('Search subjects, topics...',
                            style: TextStyle(
                                color: AppTheme.textGrey.withOpacity(0.7),
                                fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Subjects
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subjects',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textDark)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See all',
                            style: TextStyle(color: AppTheme.primaryColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) =>
                        _SubjectCard(subject: subjects[index]),
                  ),
                  const SizedBox(height: 24),

                  // Popular Videos
                  const Text('Popular Videos',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, index) => _VideoCard(index: index),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quick Stats
                  const Text('Your Progress',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _StatCard(
                              title: 'Quizzes\nTaken',
                              value: '0',
                              icon: Icons.quiz_rounded,
                              color: const Color(0xFFFF5733))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _StatCard(
                              title: 'Study\nStreak',
                              value: '0 days',
                              icon: Icons.local_fire_department_rounded,
                              color: const Color(0xFFFF9800))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _StatCard(
                              title: 'Avg\nScore',
                              value: '0%',
                              icon: Icons.trending_up_rounded,
                              color: const Color(0xFF4CAF50))),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textGrey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.go('/reports');
          if (index == 3) context.go('/profile');
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: 'Reports'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_rounded), label: 'Subjects'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Map<String, dynamic> subject;
  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (subject['color'] as Color).withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: (subject['color'] as Color).withOpacity(0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: subject['color'] as Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(subject['icon'] as IconData,
                      color: Colors.white, size: 20),
                ),
                Text(subject['name'] as String,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final int index;
  const _VideoCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Understanding Motion', 'What is a Compound?',
      'Algebra Basics', 'Cell Biology', 'Social Systems',
    ];
    final subjects = [
      'Physics', 'Chemistry', 'Mathematics', 'Biology', 'Social Science'
    ];
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05),
              blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 85,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)),
              gradient: LinearGradient(colors: [
                AppTheme.primaryColor.withOpacity(0.8),
                AppTheme.secondaryColor.withOpacity(0.8),
              ]),
            ),
            child: const Center(
                child: Icon(Icons.play_circle_fill_rounded,
                    color: Colors.white, size: 36)),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titles[index],
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(subjects[index],
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.textGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard(
      {required this.title,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05),
              blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 2),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
        ],
      ),
    );
  }
}
