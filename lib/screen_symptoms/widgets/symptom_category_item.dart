import 'package:auto_size_text/auto_size_text.dart';
import 'package:farma_segura_app/screen_symptoms/widgets/new_symptom_form.dart';
import 'package:flutter/material.dart';

class SymptomCategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final int id;

  const SymptomCategoryItem({
    this.title,
    this.color,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (builderContext) {
            return NewSymptomForm(title, id);
          },
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: AutoSizeText(
            title,
            textAlign: TextAlign.center,
            minFontSize: 14,
            maxFontSize: 20,
            style: TextStyle(color: Colors.black.withOpacity(.8)),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(.6),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
