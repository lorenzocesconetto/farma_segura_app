import 'package:farma_segura_app/models/inventory.dart';
import 'package:farma_segura_app/providers/inventories.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/screen_manage/widgets/inventory_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventorySection extends StatefulWidget {
  @override
  _InventorySectionState createState() => _InventorySectionState();
}

class _InventorySectionState extends State<InventorySection> {
  bool _loading = true;

  @override
  void initState() {
    final selectedProfileId =
        Provider.of<Profiles>(context, listen: false).selectedProfileId;
    if (selectedProfileId == null) {
      setState(() => _loading = false);
      return;
    }
    Provider.of<Inventories>(context, listen: false)
        .fetchAndSet(selectedProfileId)
        .then((_) => setState(() => _loading = false));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InventorySection oldWidget) {
    final selectedProfileId =
        Provider.of<Profiles>(context, listen: false).selectedProfileId;
    if (selectedProfileId == null) {
      setState(() => _loading = false);
      return;
    }
    Provider.of<Inventories>(context, listen: false)
        .fetchAndSet(selectedProfileId)
        .then((_) => setState(() => _loading = false));
    super.didUpdateWidget(oldWidget);
  }

  void _deleteItem(int id) {
    Provider.of<Inventories>(context, listen: false).removeItem(id);
  }

  @override
  Widget build(BuildContext context) {
    final List<Inventory> _inventories =
        Provider.of<Inventories>(context).inventories;

    final isProfileNotSelected =
        Provider.of<Profiles>(context).selectedProfileId == null;
    final problemWidget = Text(
      'Tivemos um problema',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    final noMedications = Text(
      'Você não tem estoque cadastrado',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    return Column(
      children: [
        Text('Estoque de medicamentos',
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(.65))),
        SizedBox(height: 15),
        isProfileNotSelected
            ? Text('')
            : _loading
                ? CircularProgressIndicator.adaptive()
                : _inventories == null
                    ? problemWidget
                    : _inventories.length == 0
                        ? noMedications
                        : Column(
                            children: _inventories
                                .map((e) => InventoryItem(e, _deleteItem))
                                .toList(),
                          ),
      ],
    );
  }
}
