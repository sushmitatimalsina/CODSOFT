import 'package:flutter/material.dart';
import 'dart:async';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _fadeController;
  late AnimationController _gradientController;

  late Animation<double> _iconScale;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Icon bounce animation
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _iconScale = CurvedAnimation(
      parent: _iconController,
      curve: Curves.elasticOut,
    );

    // Fade animation for text and button
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Gradient background animation
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Start animations with delay
    Timer(const Duration(milliseconds: 300), () {
      _iconController.forward();
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _fadeController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _gradientController,
      builder: (context, child) {
        Color lerpColor(Color a, Color b) {
          return Color.lerp(a, b, _gradientController.value)!;
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              title: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  "Quiz App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  lerpColor(const Color(0xFF6A11CB), const Color(0xFF2575FC)),
                  lerpColor(const Color(0xFF2575FC), const Color(0xFF6A11CB)),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _iconScale,
                    child: const Icon(
                      Icons.quiz,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      "Welcome to Quiz Master!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      "Test your knowledge and have fun!",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const QuizScreen()),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text(
                        "Start Quiz",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
