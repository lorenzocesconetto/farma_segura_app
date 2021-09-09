import 'package:flutter/material.dart';

class AuthData {
  String token;
  DateTime expirationDate;
  int userId;

  AuthData({
    @required this.expirationDate,
    @required this.token,
    @required this.userId,
  });

  AuthData.fromMap(Map data) {
    if (data['expiration'] != null) {
      this.expirationDate = DateTime.parse(data['expiration']);
    } else {
      this.expirationDate = null;
    }
    this.token = data['token'];
    this.userId = data['user_id'];
  }

  Map<String, Object> toMap() {
    if (expirationDate == null) {
      return {'token': token, 'user_id': userId, 'expiration': null};
    }
    return {
      'token': token,
      'expiration': expirationDate.toIso8601String(),
      'user_id': userId,
    };
  }
}
