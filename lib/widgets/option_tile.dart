import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;
  final bool showFeedback;

  const OptionTile({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
    required this.showFeedback,
  });

  @override
  Widget build(BuildContext context) {
    Color tileColor = Colors.white;

    if (showFeedback) {
      if (isSelected) {
        tileColor = isCorrect ? Colors.green : Colors.red;
      }
    }

    return GestureDetector(
      onTap: !showFeedback ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Text(optionText, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
