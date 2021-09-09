import 'package:farma_segura_app/models/inventory.dart';
import 'package:flutter/material.dart';

class InventoryItem extends StatelessWidget {
  final Inventory _inventory;
  final Function _deleteItem;

  InventoryItem(this._inventory, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${_inventory.inventory}'),
          ),
          title:
              Text("${_inventory.nomeComercial} - ${_inventory.apresentacao}"),
          subtitle: Text("Estoque: ${_inventory.inventory}"),
          trailing: IconButton(
            onPressed: () => _deleteItem(_inventory.id),
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
