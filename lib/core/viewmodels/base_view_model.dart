import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:guess_word_game/core/base/base_model.dart';
import 'package:guess_word_game/core/base/base_service.dart';
import 'package:guess_word_game/core/models/list_question.dart';
import 'package:guess_word_game/core/util/utils.dart';

class BaseViewModel extends BaseModel with BaseService {
  ListQuestion question = ListQuestion(questions: []);

  BuildContext _context;

  BaseViewModel(BuildContext context) {
    _context = context;
  }

  loadAsset() async {
    var db = await Utils.initDatabase();
    var questionsDb = await Utils.questions(db);
    if (questionsDb.length == 0) {
      var data = await rootBundle.loadString('assets/data.json');
      question = ListQuestion.fromJson(jsonDecode(data));
      for (var item in question.questions) {
        await Utils.insertQuestion(db, item);
      }
    } else {
      question.questions = questionsDb;
    }
    notifyListeners();
  }
}
