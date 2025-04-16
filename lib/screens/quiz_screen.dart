import 'package:flutter/material.dart';
import '/models/questions.dart';
import '/screens/result_screen.dart';
import '/widgets/answer_card.dart';
import '/widgets/next_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int?> selectedAnswerIndices = List.filled(questions.length, null);
  int questionIndex = 0;
  int score = 0;

  // This method picks the selected answer and updates the score
  void pickAnswer(int value) {
    selectedAnswerIndices[questionIndex] = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndices[questionIndex] == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  // This method goes to the next question
  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
    }
    setState(() {});
  }

  // This method goes to the previous question
  void goToPreviousQuestion() {
    if (questionIndex > 0) {
      questionIndex--;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;
    bool isFirstQuestion = questionIndex == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: selectedAnswerIndices[questionIndex] == null
                      ? () => pickAnswer(index)
                      : null,
                  child: AnswerCard(
                    currentIndex: index,
                    question: question.options[index],
                    isSelected: selectedAnswerIndices[questionIndex] == index,
                    selectedAnswerIndex: selectedAnswerIndices[questionIndex],
                    correctAnswerIndex: question.correctAnswerIndex,
                  ),
                );
              },
            ),
            // Row to show the Back and Next buttons side by side
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space buttons evenly
              children: [
                // Back Button
                if (!isFirstQuestion)
                  Expanded(
                    child: RectangularButton(
                      onPressed: goToPreviousQuestion,
                      label: 'Back',
                      color: Colors.blue,
                    ),
                  ),
                // Next Button
                Expanded(
                  child: RectangularButton(
                    onPressed: selectedAnswerIndices[questionIndex] != null
                        ? goToNextQuestion
                        : null,
                    label: isLastQuestion ? 'Finish' : 'Next',
                    color: isLastQuestion ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
