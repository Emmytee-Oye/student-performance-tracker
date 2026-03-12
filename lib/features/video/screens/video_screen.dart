import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';

class VideoScreen extends StatefulWidget {
  final String subjectName;
  final String chapterName;
  const VideoScreen({
    super.key,
    required this.subjectName,
    required this.chapterName,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool _isPlaying = false;
  bool _showControls = true;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _relatedVideos = [
    {'title': 'Sound Properties', 'duration': '40 Min', 'watched': true},
    {'title': 'Practice in Waves', 'duration': '6 Min', 'watched': false},
    {'title': 'Characteristics of Sound Wave', 'duration': '4 Min', 'watched': false},
    {'title': 'Reflection of Sound Wave', 'duration': '16 Min', 'watched': false},
    {'title': 'Human Ear', 'duration': '10 Min', 'watched': false},
    {'title': 'Sounds Bits', 'duration': '2 Min', 'watched': false},
    {'title': 'Effect of Sound', 'duration': '6 Min', 'watched': false},
  ];

  final List<Map<String, dynamic>> _ebooks = [
    {'title': 'Sound Properties', 'pages': 40, 'size': '3.4 MB'},
    {'title': 'Practice in Waves', 'pages': 6, 'size': '1.2 MB'},
    {'title': 'Characteristics of Sound Wave', 'pages': 4, 'size': '10.5 MB'},
    {'title': 'Reflection of Sound Wave', 'pages': 16, 'size': '2.5 MB'},
    {'title': 'Human Ear', 'pages': 10, 'size': '4 MB'},
    {'title': 'Sounds Bits', 'pages': 3, 'size': '20 MB'},
    {'title': 'Effect of Sound', 'pages': 6, 'size': '12 MB'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          // Video Player
          GestureDetector(
            onTap: () => setState(() => _showControls = !_showControls),
            child: Container(
              width: double.infinity,
              height: 230,
              color: Colors.black,
              child: Stack(
                children: [
                  // Background gradient
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        size: 64,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),

                  // Controls overlay
                  if (_showControls)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Top bar — NO SafeArea, use padding instead
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 28, 4, 0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => context
                                        .go('/subject/${widget.subjectName}'),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.chapterName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.fullscreen_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),

                            // Play controls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.replay_10_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => _isPlaying = !_isPlaying),
                                  child: Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.4),
                                          blurRadius: 15,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      _isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                IconButton(
                                  icon: const Icon(
                                    Icons.forward_10_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),

                            // Progress bar
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: AppTheme.primaryColor,
                                      inactiveTrackColor:
                                          Colors.white.withOpacity(0.3),
                                      thumbColor: AppTheme.primaryColor,
                                      thumbShape:
                                          const RoundSliderThumbShape(
                                              enabledThumbRadius: 5),
                                      trackHeight: 2,
                                      overlayShape:
                                          SliderComponentShape.noOverlay,
                                    ),
                                    child: Slider(
                                      value: 0.3,
                                      onChanged: (v) {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '01:05',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 10,
                                          ),
                                        ),
                                        Text(
                                          '05:45',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: Column(
              children: [
                // Tab Bar
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      _buildTab('Videos', 0),
                      _buildTab('E-Books', 1),
                    ],
                  ),
                ),

                // Tab Content
                Expanded(
                  child: _selectedTab == 0
                      ? _buildVideosList()
                      : _buildEbooksList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    isSelected ? AppTheme.primaryColor : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color:
                  isSelected ? AppTheme.primaryColor : AppTheme.textGrey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideosList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _relatedVideos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final video = _relatedVideos[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: index == 0
                ? Border.all(color: AppTheme.primaryColor, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.8),
                          AppTheme.secondaryColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    video['watched']
                        ? Icons.check_circle_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video['duration'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              if (index == 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Playing',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEbooksList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _ebooks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final ebook = _ebooks[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF2196F3),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ebook['title'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${ebook['pages']} pages | ${ebook['size']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.download_rounded,
                  color: AppTheme.primaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}