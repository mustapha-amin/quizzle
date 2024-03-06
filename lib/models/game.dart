import 'package:quizzle/core/enums.dart';
import 'package:quizzle/models/stat.dart';
import 'package:quizzle/models/user.dart';

class Game {
  String? id;
  User? host;
  List<String>? participants;
  QuizCategory? quizCategory;
  QuizDifficulty? difficulty;
  List<Stat>? stats;
  DateTime? timeCreated;

  Game({
    this.id,
    this.host,
    this.participants,
    this.quizCategory,
    this.difficulty,
    this.stats,
    this.timeCreated,
  });
}
