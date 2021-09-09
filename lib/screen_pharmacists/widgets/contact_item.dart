import 'package:flutter/material.dart';

import '../../models/pharmacist_contact.dart';

class ContactItem extends StatelessWidget {
  const ContactItem(this.contact);

  final PharmacistContact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(contact.profilePicUrl),
        ),
        title: Text(contact.name),
        subtitle: Text(contact.role),
        trailing:
            CircleAvatar(backgroundImage: AssetImage('assets/images/wpp.png')),
      ),
    );
  }
}
