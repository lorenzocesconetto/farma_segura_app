import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/providers/scheduled_medications.dart';
import 'package:farma_segura_app/providers/selected_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/backend_api.dart';
import '../../models/scheduled_med_on_date.dart';
import './med_item.dart';

class MedsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateTime = Provider.of<SelectedDate>(context).date;
    Provider.of<ScheduledMedications>(context);

    return FutureBuilder(
      future: Provider.of<BackendApi>(context, listen: false)
          .getScheduledMedsOnDate(
        profileId: Provider.of<Profiles>(context).selectedProfileId,
        date: dateTime.toIso8601String(),
      ),
      builder: (ctx, snapshot) {
        final profilesProvider = Provider.of<Profiles>(context, listen: false);
        if (profilesProvider.selectedProfileId == null ||
            profilesProvider.profiles.length == 0)
          return Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Crie um perfil antes de cadastrar medicações',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(.7)),
                ),
              ),
            ],
          );
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator.adaptive();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            return Center(
                child: Column(
              children: [
                Text('Erro! :('),
                Text('Tente novamente mais tarde'),
              ],
            ));
          } else if (snapshot.hasData) {
            final List<ScheduledMedOnDate> data = snapshot.data;
            if (data.length == 0)
              return Column(
                children: [
                  SizedBox(height: 30),
                  Text('Adicione medicações a sua rotina :)',
                      style: TextStyle(color: Colors.black.withOpacity(0.7))),
                ],
              );
            return Column(children: data.map((e) => MedItem(e)).toList());
          }
        }
        return Column(
          children: [
            SizedBox(height: 30),
            Text(
              'Você não tem medicamentos cadastrados',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7)),
            ),
          ],
        );
      },
    );
  }
}
