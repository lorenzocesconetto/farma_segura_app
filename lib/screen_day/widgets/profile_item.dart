import 'package:farma_segura_app/models/profile.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileItem extends StatelessWidget {
  final Profile profile;

  ProfileItem(
    this.profile,
  );

  @override
  Widget build(BuildContext context) {
    final selectedProfileProvider = Provider.of<Profiles>(context);
    final isActive = selectedProfileProvider.selectedProfileId == profile.id;

    final border = isActive
        ? Border.all(color: Colors.white, width: 2.0)
        : Border.all(color: Colors.transparent, width: 2.0);
    final color = isActive ? Colors.white : Colors.white60;

    return GestureDetector(
      onTap: () => selectedProfileProvider.setSelectedProfileId(profile.id),
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * .7,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: border,
                  ),
                  child: CircleAvatar(),
                ),
                Container(
                  height: constraints.maxHeight * .2,
                  child: FittedBox(
                    child:
                        Text(profile.firstName, style: TextStyle(color: color)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
