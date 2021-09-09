import 'package:farma_segura_app/models/scheduled_med.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/providers/scheduled_medications.dart';
import 'package:farma_segura_app/screen_manage/widgets/medication_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Medications extends StatefulWidget {
  @override
  _MedicationsState createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  bool _loading = true;

  @override
  void initState() {
    final selectedProfileId =
        Provider.of<Profiles>(context, listen: false).selectedProfileId;
    if (selectedProfileId == null) {
      setState(() => _loading = false);
      return;
    }
    Provider.of<ScheduledMedications>(context, listen: false)
        .fetchAndSet(selectedProfileId)
        .then((_) => setState(() => _loading = false));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Medications oldWidget) {
    final selectedProfileId =
        Provider.of<Profiles>(context, listen: false).selectedProfileId;
    if (selectedProfileId == null) {
      setState(() => _loading = false);
      return;
    }
    Provider.of<ScheduledMedications>(context, listen: false)
        .fetchAndSet(selectedProfileId)
        .then((_) => setState(() => _loading = false));
    super.didUpdateWidget(oldWidget);
  }

  void _deleteItem(int id) {
    Provider.of<ScheduledMedications>(context, listen: false).removeItem(id);
  }

  @override
  Widget build(BuildContext context) {
    final List<ScheduledMed> _scheduledMeds =
        Provider.of<ScheduledMedications>(context).scheduledMedications;
    final isProfileNotSelected =
        Provider.of<Profiles>(context).selectedProfileId == null;

    const problemWidget = Text(
      'Tivemos um problema :(',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    const noMedications = Text(
      'Você não tem medicações cadastradas na sua rotina',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 16),
    );

    return Column(
      children: [
        FittedBox(
          child: Text(
            'Medicações na sua rotina',
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(.65)),
          ),
        ),
        SizedBox(height: 15),
        isProfileNotSelected
            ? Text('')
            : _loading
                ? CircularProgressIndicator.adaptive()
                : _scheduledMeds == null
                    ? problemWidget
                    : _scheduledMeds.length == 0
                        ? noMedications
                        : Column(
                            children: _scheduledMeds
                                .map((e) => MedicationItem(e, _deleteItem))
                                .toList(),
                          ),
      ],
    );
  }
}
