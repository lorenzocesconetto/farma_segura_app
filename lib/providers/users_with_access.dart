import 'package:farma_segura_app/models/user.dart';
import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:flutter/material.dart';

class UsersWithAccess with ChangeNotifier {
  List<User> _usersWithAccess = [];
  BackendApi _api;

  UsersWithAccess({@required BackendApi api}) {
    _api = api;
  }

  get usersWithAccess => [..._usersWithAccess];

  Future<void> fetchAndSet(int profileId) async {
    _usersWithAccess = await _api.getUsersWithAccess(profileId);
    // notifyListeners();
  }

  bool removeAccess({
    @required int profileId,
    @required int userId,
  }) {
    final index = _usersWithAccess.indexWhere((user) => user.id == userId);
    if (index > -1) {
      final user = _usersWithAccess[index];
      _usersWithAccess.removeAt(index);
      _api
          .deleteAccessToUser(
        profileId: profileId,
        userId: userId,
      )
          .catchError((_) {
        _usersWithAccess.insert(index, user);
        notifyListeners();
      });
      notifyListeners();
      return true;
    }
    return false;
  }
}
