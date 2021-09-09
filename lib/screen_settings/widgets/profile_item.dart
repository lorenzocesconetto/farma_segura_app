import 'package:farma_segura_app/models/profile.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/screen_settings/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileItem extends StatelessWidget {
  final Profile profile;

  ProfileItem(this.profile);

  @override
  Widget build(BuildContext context) {
    final profilesProvider = Provider.of<Profiles>(context);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  FittedBox(
                      child: Text(
                    profile.notificationsOn ? 'Ligado' : 'Desligado',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(.7),
                    ),
                  )),
                  Switch.adaptive(
                    value: profile.notificationsOn,
                    onChanged: (value) {
                      Provider.of<Profiles>(context, listen: false)
                          .setNotification(
                              profileId: profile.id, notificationsOn: value);
                    },
                  ),
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    child: Text("${profile.firstName} ${profile.lastName}"),
                  ),
                  Text(
                    profile.username,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              profile.isOwner
                  ? Material(
                      child: CustomBottomSheet(profile),
                    )
                  : SizedBox(),
              IconButton(
                onPressed: () {
                  Provider.of<Profiles>(
                    context,
                    listen: false,
                  ).removeProfile(profile.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
