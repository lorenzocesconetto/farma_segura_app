import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/adaptive_appbar.dart';
import '../widgets/adaptive_scaffold.dart';
import '../models/pharmacist_contact.dart';
import './widgets/contact_item.dart';

class ScreenPharmacist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final contact1 = PharmacistContact(id: 'Lorenzo', name: 'Lorenzo Cano');
    // final contact2 =
    //     PharmacistContact(id: 'Vicenzo', name: 'Vicenzo Ceconetto');
    // final contact3 =
    //     PharmacistContact(id: 'Francisco', name: 'Francisco de Assis');
    // final contact4 = PharmacistContact(id: 'Rita', name: 'Rita de Cássia');
    // final mediaQuery = MediaQuery.of(context);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBarBuilder('A gente te ajuda!'),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: Provider.of<BackendApi>(context).getPharmacists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.error != null) {
                return Center(
                  child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Erro, tente novamente mais tarde')),
                );
              } else if (snapshot.hasData) {
                final List<PharmacistContact> data = snapshot.data;
                if (data.length == 0) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Text(
                      'Não temos profissionais disponíveis no momento :(',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Column(
                  children: data.map((e) => ContactItem(e)).toList(),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
