import 'package:flutter/material.dart';

import '../models/profile.dart';
import './backend_api.dart';

class Profiles with ChangeNotifier {
  BackendApi _api;
  List<Profile> _profiles;
  int _selectedProfileId;

  Profiles({
    @required BackendApi backendApi,
    @required List<Profile> initProfiles,
    @required int initialProfileId,
  }) {
    _api = backendApi;
    _selectedProfileId = initialProfileId;
    _profiles = initProfiles ?? [];
  }

  void setNotification({
    @required int profileId,
    @required bool notificationsOn,
  }) {
    try {
      final profile = getProfile(profileId);
      if (profile == null) return;
      final previousValue = profile.notificationsOn;
      profile.notificationsOn = notificationsOn;
      _api
          .setProfileNotification(
        notificationsOn: notificationsOn,
        profileId: profileId,
      )
          .catchError((_) {
        profile.notificationsOn = previousValue;
        notifyListeners();
      });
      notifyListeners();
    } catch (error) {}
  }

  int get selectedProfileId => _selectedProfileId;

  Profile getProfile(int profileId) {
    if (profileId == null || _profiles == null || _profiles.length == 0)
      return null;
    return _profiles.firstWhere((e) => e.id == profileId, orElse: () => null);
  }

  Profile get selectedProfile {
    if (selectedProfileId == null || _profiles == null || _profiles.length == 0)
      return null;
    return getProfile(_selectedProfileId);
  }

  void setSelectedProfileId(int id) {
    _selectedProfileId = id;
    notifyListeners();
  }

  Future<void> fetchAndSet() async {
    _profiles = await _api.getProfiles();
    if (_profiles.length > 0) setSelectedProfileId(_profiles[0].id);
    if (getProfile(selectedProfileId) == null) setSelectedProfileId(null);
    notifyListeners();
  }

  List<Profile> get profiles {
    if (_profiles != null && _profiles.length > 0) {
      final value = _profiles.indexWhere((e) => e.id == selectedProfileId);
      if (value == -1) {
        setSelectedProfileId(_profiles[0].id);
      }
    }
    return [..._profiles];
  }

  Future<bool> addProfile(Profile profile) async {
    try {
      final newProfile = await _api.createProfile(
        firstName: profile.firstName,
        lastName: profile.lastName,
        cpf: profile.cpf,
        username: profile.username,
      );
      _profiles.insert(0, newProfile);
      if (selectedProfileId == null) setSelectedProfileId(newProfile.id);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }

  bool removeProfile(int profileId) {
    final index = _profiles.indexWhere((item) => item.id == profileId);
    if (index > -1) {
      if (selectedProfileId == profileId) setSelectedProfileId(null);
      final profile = _profiles[index];
      _profiles.removeAt(index);
      _api.deleteProfile(profileId).catchError((_) {
        _profiles.insert(index, profile);
        notifyListeners();
      });
      notifyListeners();
      return true;
    }
    return false;
  }
}
