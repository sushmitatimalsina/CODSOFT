class Question {
  final String category;
  final String question;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.category,
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
