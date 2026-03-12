import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';

class SubjectDetailScreen extends StatefulWidget {
  final String subjectName;
  const SubjectDetailScreen({super.key, required this.subjectName});

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _chapters = [
    {
      'title': 'The Light Theories',
      'subtitle': 'The visible Spectrum',
      'videos': 14,
      'ebooks': 5,
      'progress': 0.8,
    },
    {
      'title': 'Work, Energy & Power',
      'subtitle': 'Energy Transformations',
      'videos': 10,
      'ebooks': 4,
      'progress': 0.5,
    },
    {
      'title': 'The Sound Theories',
      'subtitle': 'The visible Spectrum',
      'videos': 12,
      'ebooks': 3,
      'progress': 0.3,
    },
    {
      'title': 'The Laws of Motions',
      'subtitle': 'The visible Spectrum',
      'videos': 20,
      'ebooks': 5,
      'progress': 0.6,
    },
    {
      'title': 'Heats and Temperature',
      'subtitle': 'Thermal Energy',
      'videos': 8,
      'ebooks': 2,
      'progress': 0.1,
    },
  ];

  final List<Map<String, dynamic>> _tests = [
    {'title': 'The Light Theories', 'questions': 40, 'duration': '30 mins', 'done': true},
    {'title': 'Work, Energy & Power', 'questions': 40, 'duration': '30 mins', 'done': true},
    {'title': 'The Sound Theories', 'questions': 30, 'duration': '25 mins', 'done': false},
    {'title': 'The Laws of Motions', 'questions': 50, 'duration': '40 mins', 'done': false},
    {'title': 'Heats and Temperature', 'questions': 35, 'duration': '30 mins', 'done': false},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            backgroundColor: AppTheme.primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => context.go('/home'),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ],
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
                        const SizedBox(height: 40),
                        Text(
                          widget.subjectName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '60 Chapters | 36 Tests',
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
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Chapters'),
                Tab(text: 'Tests'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildChaptersTab(),
            _buildTestsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildChaptersTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _chapters.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final chapter = _chapters[index];
        return GestureDetector(
          onTap: () => context.go('/video/${widget.subjectName}/${chapter['title']}'),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.play_circle_outline_rounded,
                      color: AppTheme.primaryColor, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${chapter['videos']} Videos | ${chapter['ebooks']} E-Books',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: chapter['progress'],
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryColor),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${(chapter['progress'] * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _tests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final test = _tests[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: test['done']
                      ? const Color(0xFF4CAF50).withOpacity(0.1)
                      : AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  test['done']
                      ? Icons.check_circle_outline_rounded
                      : Icons.quiz_outlined,
                  color: test['done']
                      ? const Color(0xFF4CAF50)
                      : AppTheme.primaryColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${test['questions']} Questions | ${test['duration']}',
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textGrey),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => context.go('/quiz/${widget.subjectName}'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: test['done']
                        ? const Color(0xFF4CAF50).withOpacity(0.1)
                        : AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    test['done'] ? 'Retake' : 'Start',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: test['done']
                          ? const Color(0xFF4CAF50)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}