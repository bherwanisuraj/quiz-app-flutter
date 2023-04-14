import 'questions.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Questions> _questions = [
    Questions("Mangoes are red.", false),
    Questions("Oranges are Orange.", true),
    Questions("Suraj is the best.", true),
    Questions("Flutter is awesome.", true),
    Questions("You are mad.", true),
    Questions("Aliza is stupid.", true),
    Questions("Mangoes are yellow.", true),
    Questions("1+1 is not equal to 2", false)
  ];

  String getQuestion() {
    return _questions[_questionNumber].question;
  }

  bool getAnswer() {
    return _questions[_questionNumber].answer;
  }

  void nextQuestion() {
    if (_questionNumber <= _questions.length - 1) {
      _questionNumber++;
    } else {
      _questionNumber = 0;
    }
  }

  void reset() {
    _questionNumber = 0;
  }

  bool bankCheck() {
    if (_questionNumber <= _questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  int getQuestionNumber() {
    return _questionNumber;
  }
}
