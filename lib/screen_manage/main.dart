import 'package:farma_segura_app/models/profile.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/screen_day/widgets/top_container.dart';
import 'package:farma_segura_app/screen_manage/widgets/access_section.dart';
import 'package:farma_segura_app/screen_manage/widgets/inventory_section.dart';
import 'package:farma_segura_app/screen_manage/widgets/medication_section.dart';
import 'package:farma_segura_app/screen_manage/widgets/symptom_section.dart';
// import 'package:farma_segura_app/widgets/adaptive_appbar.dart';
// import 'package:farma_segura_app/widgets/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenManage extends StatefulWidget {
  @override
  _ScreenManageState createState() => _ScreenManageState();
}

class _ScreenManageState extends State<ScreenManage> {
  @override
  Widget build(BuildContext context) {
    final profilesProvider = Provider.of<Profiles>(context);
    final Profile profile =
        profilesProvider == null ? null : profilesProvider.selectedProfile;
    return SingleChildScrollView(
      child: Column(
        children: [
          TopContainer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Center(
                    child: FittedBox(
                      child: profile == null
                          ? Text(
                              'Perfil não selecionado',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                                color: Colors.blueAccent,
                                fontSize: 18,
                              ),
                            )
                          : Text(
                              'Perfil: ${profile.firstName} ${profile.lastName}',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: Colors.blueAccent,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 15),
                  if (profile != null && profile.isOwner)
                    Column(
                      children: [
                        AccessSection(),
                        SizedBox(height: 20),
                        Divider(thickness: 2),
                        SizedBox(height: 20),
                      ],
                    ),
                  Medications(),
                  SizedBox(height: 20),
                  Divider(thickness: 2),
                  SizedBox(height: 20),
                  InventorySection(),
                  SizedBox(height: 20),
                  Divider(thickness: 2),
                  SizedBox(height: 20),
                  Symptoms(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
