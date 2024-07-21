import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String profilePicUrl;
  final String uid;
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePicUrl,
    required this.uid,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      profilePicUrl: map['profilePicUrl'] as String,
      uid: map['_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePicUrl,
    String? uid,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
