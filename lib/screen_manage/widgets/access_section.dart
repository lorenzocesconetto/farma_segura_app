import 'package:farma_segura_app/models/user.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/providers/users_with_access.dart';
import 'package:farma_segura_app/screen_manage/widgets/access_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessSection extends StatefulWidget {
  @override
  _AccessSectionState createState() => _AccessSectionState();
}

class _AccessSectionState extends State<AccessSection> {
  bool _loading = true;

  @override
  void initState() {
    final selectedProfileId =
        Provider.of<Profiles>(context, listen: false).selectedProfileId;
    if (selectedProfileId == null) {
      setState(() => _loading = false);
      return;
    }
    Provider.of<Profiles>(context, listen: false)
        .fetchAndSet()
        .then((_) => setState(() => _loading = false));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AccessSection oldWidget) {
    final selectedProfileId =
        Provider.of<Profiles>(context, listen: false).selectedProfileId;
    if (selectedProfileId == null) {
      setState(() => _loading = false);
      return;
    }
    Provider.of<UsersWithAccess>(context, listen: false)
        .fetchAndSet(selectedProfileId)
        .then((_) => setState(() => _loading = false));
    super.didUpdateWidget(oldWidget);
  }

  void _deleteItem(int userId) {
    final provider = Provider.of<Profiles>(context, listen: false);
    Provider.of<UsersWithAccess>(context, listen: false).removeAccess(
      profileId: provider.selectedProfileId,
      userId: userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<User> _items =
        Provider.of<UsersWithAccess>(context).usersWithAccess;

    final isProfileNotSelected =
        Provider.of<Profiles>(context).selectedProfileId == null;
    final problemWidget = Text(
      'Tivemos um problema',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    final noMedications = Text(
      'Somente você tem acesso a este perfil',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    return Column(
      children: [
        Text('Acesso a este perfil',
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(.65))),
        SizedBox(height: 15),
        isProfileNotSelected
            ? Text('')
            : _loading
                ? CircularProgressIndicator.adaptive()
                : _items == null
                    ? problemWidget
                    : _items.length == 0
                        ? noMedications
                        : Column(
                            children: _items
                                .map((e) => AccessItem(e, _deleteItem))
                                .toList(),
                          ),
      ],
    );
  }
}
