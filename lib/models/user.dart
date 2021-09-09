import 'package:flutter/material.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    @required this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
  });

  static User fromJson(jsonData) {
    return User(
      id: jsonData['id'],
      email: jsonData['email'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
    );
  }
}
