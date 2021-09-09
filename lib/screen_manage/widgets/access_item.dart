import 'package:farma_segura_app/models/user.dart';
import 'package:flutter/material.dart';

class AccessItem extends StatelessWidget {
  final User user;
  final Function delete;
  AccessItem(this.user, this.delete);

  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey(user.id),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.person),
          ),
          title: Text("${user.firstName} ${user.lastName}"),
          subtitle: Text("${user.email}"),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => delete(user.id),
          ),
        ),
      ),
    );
  }
}
