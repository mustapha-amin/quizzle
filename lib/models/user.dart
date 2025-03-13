// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id, username, email;
  Map<int, List<int>>? scores;

  User({this.id, this.username, this.email, this.scores});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "scores": scores,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      scores: json["scores"]
    );
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    Map<int, List<int>>? scores,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      scores: scores ?? this.scores,
    );
  }
}
