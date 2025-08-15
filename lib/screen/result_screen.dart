import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Score: $score / $total", style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
