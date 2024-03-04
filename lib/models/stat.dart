class Stat {
  String? userID;
  int? score;
  DateTime? timeCompleted;

  Stat({
    this.userID,
    this.score,
    this.timeCompleted,
  });

  Map<String, dynamic> toJson() {
    return {"userID": userID, "score": score, "timeCompleted": timeCompleted};
  }

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      userID: json["userID"],
      score: json["score"],
      timeCompleted: json["timeCompleted"],
    );
  }
}
