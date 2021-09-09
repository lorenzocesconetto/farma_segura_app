import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/backend_api.dart';
import '../providers/profiles.dart';
import '../widgets/adaptive_appbar.dart';
import '../widgets/adaptive_scaffold.dart';
import './widgets/profile_item.dart';

class ScreenSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBarBuilder('Configurações'),
      body: SingleChildScrollView(
        child: Material(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notificações:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Divider(thickness: 1),
                Consumer<Profiles>(
                  builder: (context, profilesProvider, _) {
                    return Column(
                        children: profilesProvider.profiles
                            .map((e) => Column(
                                  children: [
                                    ProfileItem(e),
                                    Divider(thickness: 1),
                                  ],
                                ))
                            .toList());
                  },
                ),
                Container(
                  width: double.infinity,
                  child: LogoutButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Provider.of<BackendApi>(context, listen: false).logout(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.exit_to_app),
          SizedBox(width: 7),
          Text('SAIR', style: TextStyle(letterSpacing: 1.5, fontSize: 20)),
        ],
      ),
      style: ElevatedButton.styleFrom(primary: Colors.red),
    );
  }
}
