// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id, username, email;
  Map<int, int>? highScores;

  User({this.id, this.username, this.email, this.highScores});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "highScores": highScores,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      highScores: json["highScores"]
    );
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    Map<int, int>? highScores,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      highScores: highScores ?? this.highScores,
    );
  }
}
