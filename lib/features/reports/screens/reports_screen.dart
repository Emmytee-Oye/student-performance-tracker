import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedSubjectIndex = 0;

  final List<Map<String, dynamic>> _subjects = [
    {'name': 'All', 'color': AppTheme.primaryColor},
    {'name': 'Mathematics', 'color': const Color(0xFFFF5733)},
    {'name': 'Physics', 'color': const Color(0xFF4CAF50)},
    {'name': 'Chemistry', 'color': const Color(0xFF2196F3)},
  ];

  final List<Map<String, dynamic>> _performanceData = [
    {'subject': 'Physics', 'score': 22, 'color': const Color(0xFF4CAF50)},
    {'subject': 'Chemistry', 'score': 10, 'color': const Color(0xFF2196F3)},
    {'subject': 'Mathematics', 'score': 32, 'color': const Color(0xFFFF5733)},
    {'subject': 'Biology', 'score': 6, 'color': const Color(0xFF9C27B0)},
    {'subject': 'Social Science', 'score': 18, 'color': const Color(0xFF00BCD4)},
    {'subject': 'Reasoning', 'score': 12, 'color': const Color(0xFFFF9800)},
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
            backgroundColor: AppTheme.primaryColor,
            expandedHeight: 120,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => context.go('/home'),
            ),
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
                        const Text('Analysis Reports 📊',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('Track your learning performance',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: AppTheme.primaryColor,
                unselectedLabelColor: AppTheme.textGrey,
                indicatorColor: AppTheme.primaryColor,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Performance'),
                  Tab(text: 'Progress'),
                ],
              ),
            ),

            // Subject Filter
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _subjects.length,
                    (index) => GestureDetector(
                      onTap: () =>
                          setState(() => _selectedSubjectIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedSubjectIndex == index
                              ? (_subjects[index]['color'] as Color)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _subjects[index]['name'],
                          style: TextStyle(
                            color: _selectedSubjectIndex == index
                                ? Colors.white
                                : AppTheme.textGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPerformanceTab(),
                  _buildProgressTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textGrey,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 2) context.go('/subjects');
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

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Donut Chart Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Overall Statistics',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w500)),
                const Text('All Subjects',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 50,
                            sections: _performanceData
                                .map((data) => PieChartSectionData(
                                      color: data['color'] as Color,
                                      value:
                                          (data['score'] as int).toDouble(),
                                      title: '',
                                      radius: 30,
                                    ))
                                .toList(),
                          )),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('30%',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.textDark)),
                              Text('Overall',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppTheme.textGrey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _performanceData
                            .map((data) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: data['color'] as Color,
                                              shape: BoxShape.circle)),
                                      const SizedBox(width: 6),
                                      Expanded(
                                          child: Text(data['subject'],
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: AppTheme.textGrey),
                                              overflow:
                                                  TextOverflow.ellipsis)),
                                      Text('${data['score']}%',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.textDark)),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('Correct', '10/25'),
                    Container(width: 1, height: 30, color: Colors.grey[200]),
                    _buildStat('Attempted', '18/40'),
                    Container(width: 1, height: 30, color: Colors.grey[200]),
                    _buildStat('Avg Speed', '150 Q/Hr'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Difficulty Breakdown
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Difficulty Breakdown',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark)),
                const SizedBox(height: 16),
                _buildDifficultyBar('Easy', 0.65, const Color(0xFF4CAF50)),
                const SizedBox(height: 12),
                _buildDifficultyBar('Medium', 0.45, const Color(0xFFFF9800)),
                const SizedBox(height: 12),
                _buildDifficultyBar('Hard', 0.25, const Color(0xFFFF5733)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Weekly Bar Chart
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Weekly Activity',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark)),
                const SizedBox(height: 4),
                Text('Questions attempted per day',
                    style:
                        TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: BarChart(BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = [
                              'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
                            ];
                            return Text(days[value.toInt()],
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: AppTheme.textGrey));
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, meta) => Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                  fontSize: 10, color: AppTheme.textGrey)),
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) =>
                          FlLine(color: Colors.grey[200]!, strokeWidth: 1),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      _makeBar(0, 8), _makeBar(1, 12), _makeBar(2, 5),
                      _makeBar(3, 15), _makeBar(4, 10),
                      _makeBar(5, 18), _makeBar(6, 7),
                    ],
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Subject Progress Cards
          ...(_performanceData.map((data) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color:
                              (data['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.book_rounded,
                            color: data['color'] as Color, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['subject'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textDark)),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: (data['score'] as int) / 100,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    data['color'] as Color),
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('${data['score']}%',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: data['color'] as Color)),
                    ],
                  ),
                ),
              ))),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  BarChartGroupData _makeBar(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: y,
        gradient: const LinearGradient(
          colors: [Color(0xFFFF5733), Color(0xFFFF8C00)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        width: 16,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
      ),
    ]);
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark)),
        Text(label,
            style:
                const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
      ],
    );
  }

  Widget _buildDifficultyBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark)),
            Text('${(value * 100).toInt()}%',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
