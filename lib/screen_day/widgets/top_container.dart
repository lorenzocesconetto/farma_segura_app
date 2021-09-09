import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profiles.dart';
import './profile_item.dart';
import './add_profile_avatar.dart';

class TopContainer extends StatefulWidget {
  @override
  _TopContainerState createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  @override
  void initState() {
    Provider.of<Profiles>(context, listen: false).fetchAndSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height * .22,
      padding: EdgeInsets.only(top: mediaQuery.padding.top + 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Consumer<Profiles>(
        builder: (ctx, _profilesProvider, _) {
          if (_profilesProvider.profiles.length == 0)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // width: mediaQuery.size.width * .7,
                  // margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Adicione perfis para começar a sua jornada segura',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                AddProfileAvatar(bottomMargin: 0, topMargin: 15),
              ],
            );
          return ListView.builder(
            itemCount: _profilesProvider.profiles.length + 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) return SizedBox(width: 20);
              if (index == _profilesProvider.profiles.length + 1)
                return AddProfileAvatar();
              return ProfileItem(_profilesProvider.profiles[index - 1]);
            },
          );
        },
      ),
    );
  }
}
