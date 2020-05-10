import 'package:flutter/cupertino.dart';

class Question extends ChangeNotifier {
  int id;
  String name;
  String img;
  String answer;
  int isLocked;
  int isAnswer;

  Question(
      {this.id,
      this.name,
      this.img,
      this.answer,
      this.isLocked,
      this.isAnswer = 0});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    answer = json['answer'];
    isLocked = json['isLocked'];
    isAnswer = json['isAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['answer'] = this.answer;
    data['isLocked'] = this.isLocked;
    data['isAnswer'] = this.isAnswer;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'img': this.img,
      'answer': this.answer,
      'isLocked': this.isLocked,
      'isAnswer': this.isAnswer
    };
  }
}
