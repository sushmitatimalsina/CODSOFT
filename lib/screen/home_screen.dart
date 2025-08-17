import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = quizQuestions.map((q) => q.category).toSet().toList();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile + Points
              // Row(
              //   children: [
              //     const CircleAvatar(
              //       radius: 28,
              //       backgroundImage: AssetImage("assets/profile.png"), // add your image
              //     ),
              //     const SizedBox(width: 10),
              //     // const Column(
              //     //   crossAxisAlignment: CrossAxisAlignment.start,
              //     //   children: [
              //     //     Text("Rumi Aktar",
              //     //         style: TextStyle(
              //     //             fontSize: 18, fontWeight: FontWeight.bold)),
              //     //     Text("ID-1809",
              //     //         style: TextStyle(color: Colors.grey, fontSize: 14)),
              //     //   ],
              //     // ),
              //     const Spacer(),
              //     Container(
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //       decoration: BoxDecoration(
              //         color: Colors.blue.shade100,
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Row(
              //         children: const [
              //           Icon(Icons.emoji_events, color: Colors.blue),
              //           SizedBox(width: 5),
              //           Text("160",
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.bold)),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),

              // Banner
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF6A11CB), Color(0xFF2575FC)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Test Your Knowledge with Quizzes",
                    style: TextStyle(
                        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Search
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Categories
              const Text("Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final selectedQuestions = quizQuestions
                            .where((q) => q.category == categories[index])
                            .toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(
                              questions: selectedQuestions,
                              category: categories[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(categories[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Recent Activity (dummy UI)
              const Text("Recent Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.code, color: Colors.orange),
                        title: const Text("HTML"),
                        subtitle: const Text("30 Questions"),
                        trailing: const Text("26/30",
                            style: TextStyle(color: Colors.red)),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
