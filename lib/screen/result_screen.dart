import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _scoreController;
  late Animation<double> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scoreAnimation = Tween<double>(begin: 0, end: widget.score.toDouble())
        .animate(CurvedAnimation(parent: _scoreController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _scoreController.forward();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Score Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 10,
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: Column(
                      children: [
                        const Text(
                          "Quiz Completed!",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "${_scoreAnimation.value.toInt()} / ${widget.total}",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your Score",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Back to Home Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
