import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'result_screen.dart';


class QuizScreen extends StatefulWidget {
  final String category;
  final List<Question> questions;

  const QuizScreen({
    super.key,
    required this.category,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;

  void checkAnswer(int index) {
    setState(() {
      selectedIndex = index;
      if (index == widget.questions[currentIndex].correctIndex) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < widget.questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedIndex = null;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              score: score,
              total: widget.questions.length, userName: '',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Q${currentIndex + 1}. ${question.question}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ...List.generate(question.options.length, (index) {
              final option = question.options[index];
              final isSelected = selectedIndex == index;
              final isCorrect = question.correctIndex == index;

              Color color = Colors.grey.shade200;
              if (selectedIndex != null) {
                if (isCorrect) {
                  color = Colors.green;
                } else if (isSelected) {
                  color = Colors.red;
                }
              }

              return GestureDetector(
                onTap: selectedIndex == null ? () => checkAnswer(index) : null,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
