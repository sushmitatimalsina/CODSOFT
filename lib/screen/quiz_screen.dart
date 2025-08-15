import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../widgets/option_tile.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool showFeedback = false;

  late AnimationController _questionController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation for question slide
    _questionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _questionController, curve: Curves.easeOut));

    _questionController.forward();
  }

  void checkAnswer(int index) {
    setState(() {
      selectedIndex = index;
      showFeedback = true;
      if (index == quizQuestions[currentIndex].correctIndex) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < quizQuestions.length - 1) {
        setState(() {
          currentIndex++;
          selectedIndex = null;
          showFeedback = false;
        });
        _questionController.forward(from: 0);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(score: score, total: quizQuestions.length),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[currentIndex];
    final progress = (currentIndex + 1) / quizQuestions.length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                  minHeight: 8,
                ),
                const SizedBox(height: 20),

                // Question card
                SlideTransition(
                  position: _slideAnimation,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question ${currentIndex + 1}/${quizQuestions.length}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            question.question,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Options
                ...List.generate(question.options.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: OptionTile(
                      optionText: question.options[index],
                      isSelected: selectedIndex == index,
                      isCorrect: index == question.correctIndex,
                      showFeedback: showFeedback,
                      onTap: selectedIndex == null ? () => checkAnswer(index) : () {},
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
