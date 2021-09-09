import 'package:farma_segura_app/models/scheduled_med.dart';
import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/providers/inventories.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:flutter/material.dart';

class ScheduledMedications with ChangeNotifier {
  List<ScheduledMed> _scheduledMedications = [];
  BackendApi _api;
  Inventories _inventoryProvider;
  Profiles _profilesProvider;

  ScheduledMedications({
    api,
    inventoryProvider,
    profilesProvider,
  }) {
    _api = api;
    _inventoryProvider = inventoryProvider;
    _profilesProvider = profilesProvider;
    if (_profilesProvider != null && _api != null)
      fetchAndSet(_profilesProvider.selectedProfileId);
  }

  List<ScheduledMed> get scheduledMedications => [..._scheduledMedications];

  Future<List<ScheduledMed>> fetch(int profileId) async {
    return await _api.getScheduledMeds(profileId);
  }

  Future<String> fetchAndSet(int profileId) async {
    try {
      _scheduledMedications = await _api.getScheduledMeds(profileId);
      notifyListeners();
      return null;
    } catch (error) {
      return 'Error';
    }
  }

  bool removeItem(int id) {
    final int index = scheduledMedications.indexWhere((e) => e.id == id);
    if (index > -1) {
      final ScheduledMed item = _scheduledMedications[index];
      _scheduledMedications.removeAt(index);
      _api.deleteScheduledMeds(id).catchError((_) {
        _scheduledMedications.insert(index, item);
        notifyListeners();
      });
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> addItem({
    @required int medicationId,
    @required int inventory,
    @required int profileId,
    @required dynamic frequency,
    @required TimeOfDay time,
    @required int quantity,
  }) async {
    try {
      final data = await _api.saveScheduledMedication(
        profileId: profileId,
        medicationId: medicationId,
        frequencyScheduled: frequency,
        time: time,
        quantity: quantity,
        inventory: inventory,
      );
      if (data == null) return false;
      final newItem = data['scheduled_med'];
      final newInventory = data['inventory'];

      _scheduledMedications.insert(0, newItem);
      if (newInventory != null)
        _inventoryProvider.addItemToProvider(newInventory);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
}
