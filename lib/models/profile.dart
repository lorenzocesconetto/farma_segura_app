import 'package:flutter/material.dart';

class Profile {
  int id;
  String firstName;
  String lastName;
  String username;
  String cpf;
  bool notificationsOn;
  bool isOwner;

  Profile({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.username,
    @required this.notificationsOn,
    @required this.isOwner,
    this.cpf,
  });

  static Profile fromJson(jsonData) {
    return Profile(
      id: jsonData['id'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      username: jsonData['username'],
      isOwner: jsonData['is_owner'],
      notificationsOn: jsonData['notifications_on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'notifications_on': notificationsOn,
    };
  }

  Profile copy() => Profile(
        id: id,
        firstName: firstName,
        lastName: lastName,
        username: username,
        notificationsOn: notificationsOn,
        isOwner: isOwner,
      );
}
