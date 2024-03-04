class User {
  String? id, username, email, avatar;
  int? allTimeScores, gamesPlayed;

  User({
    this.id,
    this.username,
    this.email,
    this.avatar,
    this.allTimeScores,
    this.gamesPlayed,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "avatar": avatar,
      "gamesPlayed": gamesPlayed,
      "allTimeScores": allTimeScores,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      avatar: json["avatar"],
      allTimeScores: json["allTimeScores"],
      gamesPlayed: json["gamesPlayed"]
    );
  }
}
