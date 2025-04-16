import 'package:flutter/material.dart';

import '/models/questions.dart';
import '/screens/quiz_screen.dart';  // Import the QuizScreen to navigate back

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
        children: [
          const SizedBox(width: 1000),
          const Text(
            'Your Score: ',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: score / 9, // The score divided by the total number of questions
                  color: Colors.green,
                  backgroundColor: Colors.white,
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toString(), // Display score
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(score / questions.length * 100).round()}%', // Display percentage
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ],
          ),
          // Add the "Try Again" button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to the QuizScreen to restart the quiz
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const QuizScreen(), // Restart the quiz
                  ),
                );
              },
              child: const Text(
                'Try Again',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: Colors.blue, // Button background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
