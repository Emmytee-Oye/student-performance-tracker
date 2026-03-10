import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final String subjectName;
  const QuizScreen({super.key, required this.subjectName});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _selectedAnswer = -1;
  int _score = 0;
  int _timeLeft = 30;
  bool _answered = false;
  Timer? _timer;
  late AnimationController _progressController;
  late AnimationController _answerController;
  late Animation<double> _answerAnimation;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'A force has been applied to a ball when it is:',
      'options': ['Kicked', 'Pushed', 'Thrown', 'All of these'],
      'correct': 3,
    },
    {
      'question': 'What is Newton\'s First Law of Motion?',
      'options': [
        'F = ma',
        'An object remains at rest or in motion unless acted upon by a force',
        'For every action there is an equal and opposite reaction',
        'Energy cannot be created or destroyed',
      ],
      'correct': 1,
    },
    {
      'question': 'Which of the following is a scalar quantity?',
      'options': ['Velocity', 'Force', 'Speed', 'Acceleration'],
      'correct': 2,
    },
    {
      'question': 'What is the SI unit of force?',
      'options': ['Watt', 'Joule', 'Pascal', 'Newton'],
      'correct': 3,
    },
    {
      'question': 'Which type of energy does a moving object possess?',
      'options': [
        'Potential energy',
        'Kinetic energy',
        'Chemical energy',
        'Nuclear energy'
      ],
      'correct': 1,
    },
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _answerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _answerAnimation = CurvedAnimation(
      parent: _answerController,
      curve: Curves.easeOutBack,
    );
    _startTimer();
    _progressController.forward();
  }

  void _startTimer() {
    _timeLeft = 30;
    _timer?.cancel();
    _progressController.reset();
    _progressController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
        _nextQuestion();
      } else {
        setState(() => _timeLeft--);
      }
    });
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentIndex]['correct']) _score++;
    });
    _timer?.cancel();
    _progressController.stop();
    _answerController.forward();
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = -1;
        _answered = false;
      });
      _answerController.reset();
      _startTimer();
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    _timer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _score >= 3
                      ? const Color(0xFF4CAF50).withOpacity(0.1)
                      : AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _score >= 3 ? Icons.emoji_events_rounded : Icons.refresh_rounded,
                  size: 44,
                  color: _score >= 3 ? const Color(0xFF4CAF50) : AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _score >= 3 ? 'Great Job! 🎉' : 'Keep Practicing! 💪',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You scored $_score out of ${_questions.length}',
                style: TextStyle(fontSize: 15, color: AppTheme.textGrey),
              ),
              const SizedBox(height: 20),
              // Score Circle
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _score >= 3
                        ? [const Color(0xFF4CAF50), const Color(0xFF8BC34A)]
                        : [AppTheme.primaryColor, AppTheme.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(_score / _questions.length * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const Text('Score',
                        style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentIndex = 0;
                          _selectedAnswer = -1;
                          _score = 0;
                          _answered = false;
                        });
                        _startTimer();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        side: const BorderSide(color: AppTheme.primaryColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Retry',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Done',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFF5733), Color(0xFFFF8C00)],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.white),
                        onPressed: () => context.go('/home'),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${widget.subjectName} Quiz',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Timer
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _timeLeft <= 10
                              ? Colors.red.withOpacity(0.3)
                              : Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$_timeLeft',
                            style: TextStyle(
                              color: _timeLeft <= 10
                                  ? Colors.red[100]
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Progress Bar
                  Row(
                    children: [
                      Text(
                        '${_currentIndex + 1}/${_questions.length}',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Colors.yellow, size: 14),
                            const SizedBox(width: 4),
                            Text('$_score',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Timer progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) => LinearProgressIndicator(
                        value: 1 - _progressController.value,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _timeLeft <= 10 ? Colors.red[300]! : Colors.white,
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Question
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Question ${_currentIndex + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question['question'],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Answer Options
                    ...List.generate(
                      (question['options'] as List).length,
                      (index) => _buildOption(
                        index: index,
                        text: question['options'][index],
                        correct: question['correct'],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _answered ? _nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: _answered ? 4 : 0,
                    shadowColor: AppTheme.primaryColor.withOpacity(0.4),
                  ),
                  child: Text(
                    _currentIndex < _questions.length - 1 ? 'Next' : 'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _answered ? Colors.white : Colors.grey[500],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required int index,
    required String text,
    required int correct,
  }) {
    Color bgColor = Colors.white;
    Color borderColor = Colors.grey[200]!;
    Color textColor = AppTheme.textDark;
    IconData? trailingIcon;
    Color iconColor = Colors.transparent;

    if (_answered) {
      if (index == correct) {
        bgColor = const Color(0xFF4CAF50).withOpacity(0.1);
        borderColor = const Color(0xFF4CAF50);
        textColor = const Color(0xFF4CAF50);
        trailingIcon = Icons.check_circle_rounded;
        iconColor = const Color(0xFF4CAF50);
      } else if (index == _selectedAnswer && index != correct) {
        bgColor = AppTheme.primaryColor.withOpacity(0.1);
        borderColor = AppTheme.primaryColor;
        textColor = AppTheme.primaryColor;
        trailingIcon = Icons.cancel_rounded;
        iconColor = AppTheme.primaryColor;
      }
    } else if (index == _selectedAnswer) {
      bgColor = AppTheme.primaryColor.withOpacity(0.1);
      borderColor = AppTheme.primaryColor;
    }

    return ScaleTransition(
      scale: _answered ? _answerAnimation : const AlwaysStoppedAnimation(1.0),
      child: GestureDetector(
        onTap: () => _selectAnswer(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: borderColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    ['A', 'B', 'C', 'D'][index],
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _answered && index == correct
                          ? const Color(0xFF4CAF50)
                          : _answered && index == _selectedAnswer
                              ? AppTheme.primaryColor
                              : AppTheme.textGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(trailingIcon, color: iconColor, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}