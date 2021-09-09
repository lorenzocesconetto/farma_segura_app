import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/screen_symptoms/widgets/symptom_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/adaptive_appbar.dart';
import '../widgets/adaptive_scaffold.dart';
import '../models/symptom_category.dart';

class ScreenSymptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AdaptiveScaffold(
      appBar: AdaptiveAppBarBuilder('Sintomas'),
      body: FutureBuilder(
        future: Provider.of<BackendApi>(context, listen: false)
            .getSymptomCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Tivemos um problema :('));
            } else if (snapshot.hasData) {
              final List<SymptomCategory> data = snapshot.data;
              return SafeArea(
                child: GridView(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: (mediaQuery.size.width / 3) * 0.9,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: mediaQuery.size.width * 0.05,
                      mainAxisSpacing: 20,
                    ),
                    padding: const EdgeInsets.all(10),
                    children: data
                        .map((e) => Material(
                              child: SymptomCategoryItem(
                                id: e.id,
                                title: e.title,
                                color: Colors.lightBlue,
                              ),
                            ))
                        .toList()),
              );
            }
          }
          return Text('Erro :(');
        },
      ),
    );
  }
}
