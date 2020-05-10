import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_word_game/core/enums/connectivity_status.dart';
import 'package:guess_word_game/core/models/question.dart';
import 'package:guess_word_game/core/translation/app_translations.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Utils {
  static Pattern emailPattern = r'^[a-zA-Z0-9]';
  static const platform = const MethodChannel('flutter.native/helper');

  static bool isInDebugMode() {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static bool checkNetwork(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.Offline) {
      return false;
    }
    return true;
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static double resizeWidthUtil(BuildContext context, double value) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenDesignWidth = 375;
    return (screenWidth * value) / screenDesignWidth;
  }

  static double resizeHeightUtil(BuildContext context, double value) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenDesignHeight = 812;

    if (screenHeight < 800) {
      return (screenHeight * value) / screenDesignHeight;
    } else {
      return (screenHeight * value) / 980;
    }
  }

  static String getString(BuildContext context, String value) =>
      AppTranslations.of(context).text(value);

  static Future<Database> initDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'question_game.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE question(id INTEGER PRIMARY KEY, name TEXT, img TEXT, answer TEXT, isAnswer INTEGER, isLocked INTEGER)",
        );
      },
      version: 1,
    );
    return database;
  }

  static Future<void> insertQuestion(Database db, Question question) async {
    var questionDb = Question(
        id: question.id,
        name: question.name,
        img: question.img,
        answer: question.answer,
        isAnswer: question.isAnswer,
        isLocked: question.isLocked);
    await db.insert(
      'question',
      questionDb.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Question>> questions(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('question');
    return List.generate(maps.length, (i) {
      return Question.fromJson(maps[i]);
    });
  }

  static Future<void> updateQuestion(Database db,Question question) async {
    await db.update(
      'question',
      question.toMap(),
      where: "id = ?",
      whereArgs: [question.id],
    );
  }
}
