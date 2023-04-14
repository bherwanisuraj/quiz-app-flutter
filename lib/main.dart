import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzics/Quizbrain/quizbrain.dart';

import 'Quizbrain/questions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Quizzics(),
  ));
}

class Quizzics extends StatefulWidget {
  const Quizzics({Key? key}) : super(key: key);

  @override
  State<Quizzics> createState() => _QuizzicsState();
}

class _QuizzicsState extends State<Quizzics> {
  List<Icon> scoreKeeper = [];
  List<Icon> options = [
    const Icon(CupertinoIcons.xmark, color: Colors.red),
    const Icon(
      CupertinoIcons.check_mark,
      color: Colors.green,
    ),
  ];

  QuizBrain questionBank = QuizBrain();

  restartQuiz(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Quiz Over"),
            content: const Text('Do you want to restart the quiz?'),
            actions: [
              TextButton(
                  onPressed: () {
                    scoreKeeper = [];
                    setState(() {
                      Navigator.pop(context);
                      questionBank.reset();
                    });
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  Text getText() {
    if (questionBank.getQuestionNumber() <= 7) {
      print("Question Number " + questionBank.getQuestionNumber().toString());
      return Text(
        questionBank.getQuestion(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
        ),
        textAlign: TextAlign.center,
      );
    } else if (questionBank.getQuestionNumber() == 8) {
      return Text("No Text");
    } else {
      return Text("no Question");
    }
  }

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (questionBank.getAnswer() == userAnswer) {
        scoreKeeper.add(options[1]);
      } else {
        scoreKeeper.add(options[0]);
      }
      print('question number before ' +
          questionBank.getQuestionNumber().toString());
      questionBank.nextQuestion();
      print('question number after ' +
          questionBank.getQuestionNumber().toString());
    });
  }

  bool quizBrain(Questions q) {
    return q.answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: getText(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 50.0),
                  child: TextButton(
                    onPressed: () {
                      if (questionBank.getQuestionNumber() <= 6) {
                        checkAnswer(true);
                      } else if (questionBank.getQuestionNumber() == 7) {
                        checkAnswer(true);
                        restartQuiz(context);
                      }
                    },
                    child: const Text(
                      "Correct",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      primary: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 50.0),
                  child: TextButton(
                    onPressed: () {
                      if (questionBank.getQuestionNumber() <= 6) {
                        checkAnswer(false);
                      } else if (questionBank.getQuestionNumber() == 7) {
                        checkAnswer(false);
                        restartQuiz(context);
                      }
                    },
                    child: const Text(
                      'Incorrect',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      primary: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Row(
                  children: scoreKeeper,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
