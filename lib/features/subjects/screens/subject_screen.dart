import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  final List<Map<String, dynamic>> _subjects = const [
    {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'color': Color(0xFFFF5733), 'chapters': 60, 'tests': 36},
    {'name': 'Physics', 'icon': Icons.science_rounded, 'color': Color(0xFF4CAF50), 'chapters': 48, 'tests': 30},
    {'name': 'Chemistry', 'icon': Icons.biotech_rounded, 'color': Color(0xFF2196F3), 'chapters': 52, 'tests': 28},
    {'name': 'Biology', 'icon': Icons.eco_rounded, 'color': Color(0xFF9C27B0), 'chapters': 44, 'tests': 24},
    {'name': 'Reasoning', 'icon': Icons.psychology_rounded, 'color': Color(0xFFFF9800), 'chapters': 30, 'tests': 20},
    {'name': 'Social Science', 'icon': Icons.public_rounded, 'color': Color(0xFF00BCD4), 'chapters': 36, 'tests': 22},
    {'name': 'English', 'icon': Icons.menu_book_rounded, 'color': Color(0xFFE91E63), 'chapters': 40, 'tests': 25},
    {'name': 'Geography', 'icon': Icons.map_rounded, 'color': Color(0xFF795548), 'chapters': 28, 'tests': 18},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            automaticallyImplyLeading: false,
            backgroundColor: AppTheme.primaryColor,
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
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'All Subjects 📚',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Choose a subject to start learning',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final subject = _subjects[index];
                  return GestureDetector(
                    onTap: () => context.go('/subject/${subject['name']}'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Icon
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: (subject['color'] as Color)
                                  .withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              subject['icon'] as IconData,
                              color: subject['color'] as Color,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subject['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${subject['chapters']} Chapters • ${subject['tests']} Tests',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textGrey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: 0.0,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        subject['color'] as Color),
                                    minHeight: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Arrow
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: (subject['color'] as Color)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: subject['color'] as Color,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _subjects.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textGrey,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) context.go('/home');
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