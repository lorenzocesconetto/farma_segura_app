import 'package:farma_segura_app/models/inventory.dart';
import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:flutter/material.dart';

class Inventories with ChangeNotifier {
  BackendApi _api;
  List<Inventory> _inventories;

  Inventories({
    @required BackendApi api,
    @required List<Inventory> initialValues,
  }) {
    _api = api;
    _inventories = initialValues ?? [];
  }

  get inventories => [..._inventories];

  Future<String> fetchAndSet(int profileId) async {
    try {
      _inventories = await _api.getInventory(profileId);
      notifyListeners();
      return null;
    } catch (error) {
      return 'Erro';
    }
  }

  bool removeItem(int id) {
    final index = _inventories.indexWhere((item) => item.id == id);
    if (index > -1) {
      final item = _inventories[index];
      _inventories.removeAt(index);
      _api.deleteInventory(id).catchError((_) {
        _inventories.insert(index, item);
        notifyListeners();
      });
      notifyListeners();
      return true;
    }
    return false;
  }

  void addItemToProvider(Inventory item) {
    // _inventories.add(item);
    _inventories.insert(0, item);
    notifyListeners();
  }

  Future<bool> addItem({
    @required int medicationId,
    @required int inventory,
    @required int profileId,
  }) async {
    try {
      final newInventory = await _api.saveInventory(
          medicationId: medicationId,
          inventory: inventory,
          profileId: profileId);
      _inventories.insert(0, newInventory);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
}
