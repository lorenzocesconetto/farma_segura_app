import 'dart:async';
import 'dart:convert';

import 'package:farma_segura_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/profile.dart';
import '../models/inventory.dart';
import '../models/medication.dart';
import '../models/pharmacist_contact.dart';
import '../models/symptom_category.dart';
import '../models/symptom.dart';
import '../models/auth_data.dart';
import '../models/local_storage.dart';
import '../models/scheduled_med_on_date.dart';
import '../models/scheduled_med.dart';
import '../screen_add_medication/med_frequency.dart';

class BackendApi with ChangeNotifier {
  AuthData _authData;
  Timer _authTimer;
  // static const _baseUrl = 'http://10.0.2.2:5000/api/v0/';
  static const _baseUrl = 'http://localhost:5000/api/v0/';
  static const _headersWithJson = {"Content-Type": "application/json"};
  static const _scheduledFrequecyMap = {
    MedFrequency.everyday: 'everyday',
    MedFrequency.everyOtherDay: 'every_other_day',
  };

  Map<String, String> _headersWithJsonAuth(String email, String password) {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    return <String, String>{'authorization': basicAuth}
      ..addAll(_headersWithJson);
  }

  Map<String, String> get _headersWithToken =>
      <String, String>{'Authorization': 'Bearer ${_authData.token}'};

  Map<String, String> get _headersWithJsonToken =>
      _headersWithToken..addAll(_headersWithJson);

  Future<void> setProfileNotification({
    @required int profileId,
    @required bool notificationsOn,
  }) async {
    final url = Uri.parse(_baseUrl + 'profile_notification');
    final payload = {
      'profile_id': profileId,
      'notifications_on': notificationsOn,
    };
    final response = await http.post(
      url,
      headers: _headersWithJsonToken,
      body: json.encode(payload),
    );
    if (response.statusCode != 200) throw Exception('Error');
  }

  Future<List<Profile>> getProfiles() async {
    final url = Uri.parse(_baseUrl + 'profile');
    final response = await http.get(url, headers: _headersWithToken);
    final data = json.decode(response.body);
    final List<Profile> results = [];
    for (final e in data) {
      results.add(Profile.fromJson(e));
    }
    return results;
  }

  Future<String> shareProfile({
    @required int profileId,
    @required String email,
  }) async {
    final url = Uri.parse(_baseUrl + 'profile_access');
    final payload = {
      'profile_id': profileId,
      'email': email,
    };
    try {
      final response = await http.post(url,
          headers: _headersWithJsonToken, body: json.encode(payload));
      if (response.statusCode != 200) {
        return 'Tente novamente mais tarde';
      }
      return null;
    } catch (error) {
      return 'Tente novamente mais tarde';
    }
  }

  Future<void> saveSymptom({
    @required int profileId,
    @required DateTime date,
    @required int symptomId,
    @required int intensity,
  }) async {
    final url = Uri.parse(_baseUrl + "user_symptom");
    final payload = {
      'profile_id': profileId,
      'date': date.toIso8601String(),
      'symptom_id': symptomId,
      'intensity': intensity,
    };
    final response = await http.post(
      url,
      body: json.encode(payload),
      headers: _headersWithJsonToken,
    );
    if (response.statusCode != 200) {
      throw Exception('Error');
    }
  }

  Future<List<SymptomCategory>> getSymptomCategories() async {
    final url = Uri.parse(_baseUrl + "symptom_category");
    final response = await http.get(url, headers: _headersWithJsonToken);
    final data = json.decode(response.body);
    final List<SymptomCategory> parsedData = [];
    for (final e in data) {
      parsedData.add(SymptomCategory(id: e['id'], title: e['name']));
    }
    return parsedData;
  }

  Future<List<PharmacistContact>> getPharmacists() async {
    final url = Uri.parse(_baseUrl + 'pharmacists');
    final response = await http.get(url, headers: _headersWithToken);
    final data = json.decode(response.body);
    final List<PharmacistContact> parsedData = [];
    for (final e in data) {
      parsedData.add(PharmacistContact(
        name: e['name'],
        id: e['id'],
        whatappNumber: e['whatapp_number'],
        role: e['role'],
        profilePicUrl: e['profile_pic_url'],
      ));
    }
    return parsedData;
  }

  Future<List<Inventory>> getInventory(int profileId) async {
    final url =
        Uri.parse(_baseUrl + 'medication_inventory?profile_id=$profileId');
    try {
      final response = await http.get(url, headers: _headersWithToken);
      if (response.statusCode != 200) {
        throw Exception('');
      }
      final data = json.decode(response.body);
      final List<Inventory> parsedData = [];
      for (final e in data) {
        parsedData.add(Inventory.fromJson(e));
      }
      return parsedData;
    } catch (error) {
      throw Exception('');
    }
  }

  Future<Inventory> saveInventory({
    @required int medicationId,
    @required int inventory,
    @required int profileId,
  }) async {
    final url = Uri.parse(_baseUrl + '');
    final payload = {
      'medication_id': medicationId,
      'inventory': inventory,
      'profile_id': profileId,
    };
    final response = await http.post(
      url,
      headers: _headersWithJsonToken,
      body: json.encode(payload),
    );
    if (response.statusCode != 200) {
      throw Exception('');
    }
    final data = json.decode(response.body);
    return Inventory.fromJson(data);
  }

  Future<Map> saveScheduledMedication({
    @required int medicationId,
    @required dynamic frequencyScheduled,
    @required TimeOfDay time,
    @required int quantity,
    @required int profileId,
    int inventory,
  }) async {
    final payload = {
      'profile_id': profileId,
      'medication_id': medicationId,
      'frequency_scheduled': _scheduledFrequecyMap[frequencyScheduled],
      'hour': time.hour,
      'minute': time.minute,
      'quantity': quantity,
      'inventory': inventory,
    };

    final url = Uri.parse(_baseUrl + 'user_medication');
    try {
      final response = await http.post(
        url,
        headers: _headersWithJsonToken,
        body: json.encode(payload),
      );
      if (response.statusCode != 200) {
        return null;
      }
      final data = json.decode(response.body);
      Inventory inventoryObject;
      if (data['inventory'] == null) {
        inventoryObject = null;
      } else {
        inventoryObject = Inventory.fromJson(data['inventory']);
      }
      return {
        'scheduled_med': ScheduledMed.fromJson(data['user_medication']),
        'inventory': inventoryObject,
      };
    } catch (error) {
      return null;
    }
  }

  Future<List<Medication>> getAutocompleteSuggestions(
      String query, int numSuggestions) async {
    final url = Uri.parse(
        _baseUrl + 'autocomplete?query=$query&num_suggestions=$numSuggestions');
    final response = await http.get(
      url,
      headers: _headersWithToken,
    );
    final data = json.decode(response.body);
    final List<Medication> parsedData = [];
    for (final e in data) {
      parsedData.add(
        Medication.fromJson(e),
      );
    }
    return parsedData;
  }

  Future<List<Symptom>> getUserSymptoms({
    int page: 1,
    int perPage: 20,
    @required int profileId,
  }) async {
    final url = Uri.parse(_baseUrl +
        'user_symptom?profile_id=$profileId&page=$page&per_page=$perPage');
    final response = await http.get(url, headers: _headersWithToken);
    final data = json.decode(response.body);
    List<Symptom> parsedData = [];
    if (data is List) {
      for (final e in data) {
        parsedData.add(Symptom.fromJson(e));
      }
    }
    return parsedData;
  }

  Future<void> saveMedicationTaken({
    @required int profileId,
    @required int medicationId,
    @required int quantity,
    @required String date,
    @required bool taken,
  }) async {
    final url = Uri.parse(_baseUrl + 'medication_taken');
    final payload = {
      'profile_id': profileId,
      'medication_id': medicationId,
      'quantity': quantity,
      'original_timestamp': date,
      'taken': taken,
    };
    await http.post(
      url,
      headers: _headersWithJsonToken,
      body: json.encode(payload),
    );
  }

  Future<List<ScheduledMed>> getScheduledMeds(int profileId) async {
    if (profileId == null || _authData == null) return [];
    final url = Uri.parse(_baseUrl + 'user_medication?profile_id=$profileId');
    final response = await http.get(url, headers: _headersWithToken);
    final data = json.decode(response.body);
    final List<ScheduledMed> parsedData = [];
    if (data is List) {
      for (final e in data) {
        parsedData.add(ScheduledMed.fromJson(e));
      }
    }
    return parsedData;
  }

  Future<List<User>> getUsersWithAccess(int profileId) async {
    final url = Uri.parse(_baseUrl + 'profile_access?profile_id=$profileId');
    final response = await http.get(url, headers: _headersWithToken);
    if (response.statusCode != 200) throw Exception('Error');
    final data = json.decode(response.body);
    final List<User> parsedResults = [];
    if (data is List) {
      for (final e in data) {
        parsedResults.add(User.fromJson(e));
      }
    }
    return parsedResults;
  }

  Future<void> deleteAccessToUser({
    @required int userId,
    @required int profileId,
  }) async {
    final url = Uri.parse(
        _baseUrl + 'profile_access?user_id=$userId&profile_id=$profileId');
    final response = await http.delete(url, headers: _headersWithToken);
    if (response.statusCode != 200) {
      throw Exception('Unable to remove access');
    }
  }

  Future<void> deleteProfile(int id) async {
    final url = Uri.parse(_baseUrl + 'profile?profile_id=$id');
    final response = await http.delete(url, headers: _headersWithToken);
    if (response.statusCode != 200) {
      throw Exception('Unable to delete profile');
    }
  }

  Future<void> deleteSymptom(int id, int profileId) async {
    final url =
        Uri.parse(_baseUrl + 'user_symptom?profile_id=$profileId&id=$id');
    await http.delete(url, headers: _headersWithToken);
  }

  Future<void> deleteInventory(int id) async {
    final url = Uri.parse(_baseUrl + 'medication_inventory?id=$id');
    await http.delete(url, headers: _headersWithToken);
  }

  Future<void> deleteScheduledMeds(int id) async {
    final url = Uri.parse(_baseUrl + 'user_medication?id=$id');
    await http.delete(url, headers: _headersWithToken);
  }

  Future<List<ScheduledMedOnDate>> getScheduledMedsOnDate({
    @required String date,
    @required int profileId,
  }) async {
    final url = Uri.parse(
        _baseUrl + 'all_medications?profile_id=$profileId&date=$date');
    final response = await http.get(url, headers: _headersWithToken);
    final data = json.decode(response.body);
    final List<ScheduledMedOnDate> parsedData = [];
    if (data is List) {
      for (final e in data) {
        parsedData.add(ScheduledMedOnDate.fromJson(e));
      }
      return parsedData;
    }
  }

  Future<Profile> createProfile({
    @required String firstName,
    @required String lastName,
    @required String cpf,
    @required String username,
  }) async {
    username = username.toLowerCase().trim();
    cpf = cpf.replaceAll('.', '');
    cpf = cpf.replaceAll('-', '');
    final payload = {
      'first_name': firstName,
      'last_name': lastName,
      'cpf': cpf,
      'username': username
    };
    final url = Uri.parse(_baseUrl + 'profile');
    try {
      final response = await http.post(
        url,
        body: json.encode(payload),
        headers: _headersWithJsonToken,
      );
      final data = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception('Error');
      }
      return Profile.fromJson(data['data']);
    } catch (error) {
      throw Exception('Error');
    }
  }

  Future<bool> checkUsername(String username) async {
    username = username.toLowerCase().trim();
    final url = Uri.parse(_baseUrl + 'username_check?username=$username');
    try {
      final response = await http.get(url, headers: _headersWithToken);
      final bool data = json.decode(response.body);
      return data;
    } catch (error) {
      return null;
    }
  }

  Future<http.Response> loginUser({
    @required String email,
    @required String password,
  }) async {
    final url = Uri.parse(_baseUrl + 'token');
    email = email.toLowerCase().trim();
    try {
      final response = await http.post(
        url,
        headers: _headersWithJsonAuth(email, password),
      );
      _authData = AuthData.fromMap(json.decode(response.body));
      notifyListeners();
      await LocalStorage.saveUserAuthData(_authData);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<http.Response> registerUser({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
    @required String cpf,
  }) async {
    email = email.toLowerCase().trim();
    cpf = cpf.replaceAll('.', '');
    cpf = cpf.replaceAll('-', '');
    final url = Uri.parse(_baseUrl + 'register');
    final payload = {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'cpf': cpf,
    };
    try {
      final response = await http.post(
        url,
        headers: _headersWithJson,
        body: json.encode(payload),
      );
      if (response.statusCode != 200) {
        throw Exception('An error ocurred');
      }
      _authData = AuthData.fromMap(json.decode(response.body));
      await LocalStorage.saveUserAuthData(_authData);
      notifyListeners();
      return response;
    } catch (error) {
      throw Exception('Something went wrong');
    }
  }

  bool get isAuthenticated => token != null;

  int get userId => _authData.userId;

  String get token {
    if (_authData != null &&
        _authData.userId != null &&
        // _authData.expirationDate.isAfter(DateTime.now()) &&
        // _authData.expirationDate != null &&
        _authData.token != null) {
      return _authData.token;
    }
    return null;
  }

  Future<bool> tryAutoLogin() async {
    _authData = await LocalStorage.getUserAuthData();
    if (_authData != null && isAuthenticated) {
      notifyListeners();
      // _autoLogout();
      return true;
    }
    return false;
  }

  Future<void> forgotPassword(
    String email,
  ) async {
    email = email.toLowerCase().trim();
    final url = Uri.parse(_baseUrl + 'forgot_password');
    try {
      final response = await http.post(
        url,
        headers: _headersWithJson,
        body: json.encode({'email': email}),
      );
      if (response.statusCode != 200) throw Exception('Status code not 200');
    } catch (error) {
      throw Exception('Something went wrong');
    }
  }

  Future<void> logout() async {
    _authData = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    await LocalStorage.clearUserAuth();
  }

  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timeToExpiry =
  //       _authData.expirationDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
