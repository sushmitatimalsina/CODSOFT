import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../widgets/option_tile.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool showFeedback = false;

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
  Widget build(BuildContext context) {
    final question = quizQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Question ${currentIndex + 1}/${quizQuestions.length}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(question.question, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...List.generate(question.options.length, (index) {
              return OptionTile(
                optionText: question.options[index],
                isSelected: selectedIndex == index,
                isCorrect: index == question.correctIndex,
                onTap: () => checkAnswer(index),
                showFeedback: showFeedback,
              );
            }),
          ],
        ),
      ),
    );
  }
}
