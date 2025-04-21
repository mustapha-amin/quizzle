// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id, username, email;
  Map<String, int>? highScores;

  User({this.id, this.username, this.email, this.highScores});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "highScores": highScores as Map<String, int>,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    Map<String, int>? highScores = json['highScores'] != null
        ? Map<String, int>.from(json['highScores'] as Map<String, dynamic>)
        : null;
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      highScores: highScores,
    );
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    Map<String, int>? highScores,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      highScores: highScores ?? this.highScores,
    );
  }
}
