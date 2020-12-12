// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    @required this.success,
    @required this.token,
    @required this.userId,
  });

  final bool success;
  final String token;
  final String userId;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    success: json["success"],
    token: json["token"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "userId": userId,
  };
}
