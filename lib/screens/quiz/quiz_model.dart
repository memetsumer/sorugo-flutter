class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    required this.isLocked,
    required this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect,
  });
}

const List<String> optionTitles = ["A", "B", "C", "D", "E"];

final questions = [
  Question(
    text: 'What is the capital of India?',
    options: [
      Option(text: 'New Delhi', isCorrect: true),
      Option(text: 'Mumbai', isCorrect: false),
      Option(text: 'Chennai', isCorrect: false),
      Option(text: 'Kolkata', isCorrect: false),
    ],
    isLocked: false,
    selectedOption: null,
  ),
  Question(
    text: 'What is the capital of USA?',
    options: [
      Option(text: 'New Delhi', isCorrect: false),
      Option(text: 'Mumbai', isCorrect: false),
      Option(text: 'Chennai', isCorrect: false),
      Option(text: 'Kolkata', isCorrect: true),
    ],
    isLocked: false,
    selectedOption: null,
  ),
  Question(
    text: 'What is the capital of UK?',
    options: [
      Option(text: 'New Delhi', isCorrect: false),
      Option(text: 'Mumbai', isCorrect: false),
      Option(text: 'Chennai', isCorrect: false),
      Option(text: 'Kolkata', isCorrect: true),
    ],
    isLocked: false,
    selectedOption: null,
  ),
  Question(
    text: 'What is the capital of Australia?',
    options: [
      Option(text: 'New Delhi', isCorrect: false),
      Option(text: 'Mumbai', isCorrect: false),
      Option(text: 'Chennai', isCorrect: false),
      Option(text: 'Kolkata', isCorrect: true),
    ],
    isLocked: false,
    selectedOption: null,
  ),
  Question(
    text: 'What is the capital of Canada?',
    options: [
      Option(text: 'New Delhi', isCorrect: false),
      Option(text: 'Mumbai', isCorrect: false),
      Option(text: 'Chennai', isCorrect: false),
      Option(text: 'Kolkata', isCorrect: true),
    ],
    isLocked: false,
    selectedOption: null,
  ),
];
