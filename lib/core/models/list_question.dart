import 'package:guess_word_game/core/models/question.dart';

class ListQuestion {
  List<Question> questions;

  ListQuestion({this.questions});

  ListQuestion.fromJson(Map<String, dynamic> json) {
    questions = (json['data'] as List)
        .map((value) => Question.fromJson(value))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.questions;
    return data;
  }
}
