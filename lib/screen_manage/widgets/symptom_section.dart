import 'package:farma_segura_app/models/symptom.dart';
import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/screen_manage/widgets/symptom_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Symptoms extends StatefulWidget {
  @override
  _SymptomsState createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  List<Symptom> _symptoms;
  BackendApi apiProvider;
  bool _loading = true;

  void _deleteItem(int id) async {
    setState(() => _symptoms.removeWhere((element) => element.id == id));
    await apiProvider.deleteSymptom(
      id,
      Provider.of<Profiles>(context, listen: false).selectedProfileId,
    );
  }

  @override
  void initState() {
    if (Provider.of<Profiles>(context, listen: false).selectedProfileId ==
        null) {
      setState(() => _loading = false);
      return;
    }
    apiProvider = Provider.of<BackendApi>(context, listen: false);
    apiProvider
        .getUserSymptoms(
      profileId:
          Provider.of<Profiles>(context, listen: false).selectedProfileId,
    )
        .then((value) {
      setState(() {
        _symptoms = value;
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Symptoms oldWidget) {
    if (Provider.of<Profiles>(context, listen: false).selectedProfileId ==
            null ||
        apiProvider == null) {
      setState(() => _loading = false);
      return;
    }
    apiProvider
        .getUserSymptoms(
      profileId:
          Provider.of<Profiles>(context, listen: false).selectedProfileId,
    )
        .then((value) {
      setState(() {
        _symptoms = value;
        _loading = false;
      });
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final isProfileNotSelected =
        Provider.of<Profiles>(context).selectedProfileId == null;

    const problemWidget = Text(
      'Tivemos um problema :(',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    const noMedications = Text(
      'Você não tem sintomas cadastrados',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    return Column(
      children: [
        Text('Sintomas registrados',
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(.65))),
        SizedBox(height: 15),
        Container(
          height: _symptoms != null && _symptoms.length > 0 ? 300 : 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isProfileNotSelected ? null : Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
          child: isProfileNotSelected
              ? Text('')
              : _loading
                  ? CircularProgressIndicator.adaptive()
                  : _symptoms == null
                      ? problemWidget
                      : _symptoms.length == 0
                          ? noMedications
                          : Container(
                              height: 100,
                              child: ListView(
                                children: _symptoms
                                    .map((e) => SymptomItem(e, _deleteItem))
                                    .toList(),
                              ),
                            ),
        ),
      ],
    );
  }
}
