import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/screen_day/widgets/add_medication_button.dart';
import 'package:farma_segura_app/screen_day/widgets/meds_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/date_selection.dart';
import './widgets/top_container.dart';

class ScreenDay extends StatefulWidget {
  @override
  _ScreenDayState createState() => _ScreenDayState();
}

class _ScreenDayState extends State<ScreenDay> {
  var _refreshDummy = false;

  void toggleRefreshDummy() {
    setState(() {
      _refreshDummy = !_refreshDummy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopContainer(),
            DateSelection(),
            MedsContainer(),
            if (Provider.of<Profiles>(context).selectedProfileId != null)
              AddMedicationButton(toggleRefreshDummy),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
