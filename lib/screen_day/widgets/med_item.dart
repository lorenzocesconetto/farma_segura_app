import 'package:auto_size_text/auto_size_text.dart';
import 'package:farma_segura_app/providers/profiles.dart';
import 'package:farma_segura_app/providers/selected_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/backend_api.dart';
import '../../models/scheduled_med_on_date.dart';
import './med_action.dart';
import './med_message.dart';

enum Option {
  confirmed,
  refused,
}

class MedItem extends StatefulWidget {
  final ScheduledMedOnDate userMed;

  MedItem(this.userMed);

  @override
  _MedItemState createState() => _MedItemState();
}

class _MedItemState extends State<MedItem> {
  Option option;

  void handleButtonPress({
    @required Option prevOption,
    @required bool taken,
    @required Option newOption,
  }) {
    if (prevOption == newOption) return null;

    setState(() {
      if (newOption == Option.refused) {
        widget.userMed.taken = false;
        if (widget.userMed.inventory != null) {
          if (prevOption == Option.confirmed)
            widget.userMed.inventory += widget.userMed.quantity;
        }
      } else if (newOption == Option.confirmed) {
        if (widget.userMed.inventory != null)
          widget.userMed.inventory -= widget.userMed.quantity;
        widget.userMed.taken = true;
      }

      option = newOption;
    });
    Provider.of<BackendApi>(context, listen: false).saveMedicationTaken(
      profileId:
          Provider.of<Profiles>(context, listen: false).selectedProfileId,
      date: widget.userMed.dateTime.toIso8601String(),
      medicationId: widget.userMed.medicationId,
      quantity: widget.userMed.quantity,
      taken: taken,
    );
  }

  @override
  void initState() {
    if (widget.userMed.taken == true) {
      option = Option.confirmed;
    } else if (widget.userMed.taken == false) {
      option = Option.refused;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedDate =
        Provider.of<SelectedDate>(context, listen: false).date;
    final now = DateTime.now();
    DateTime todayLimit = new DateTime(now.year, now.month, now.day + 1);
    var enableButtons = false;
    if (_selectedDate.isBefore(todayLimit) &&
        _selectedDate.isAfter(todayLimit.add(Duration(days: -5)))) {
      enableButtons = true;
    }
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MedMessage(widget.userMed),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 6,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 14),
                    Image.asset(
                      'assets/images/pill@3x.png',
                      height: 25,
                    ),
                  ],
                ),
              ),
              title: Container(
                // padding: EdgeInsets.only(top: 4),
                margin: EdgeInsets.only(top: 6),
                alignment: Alignment.centerLeft,
                height: 20,
                child: AutoSizeText(
                  '${widget.userMed.nomeComercial} - ${widget.userMed.apresentacao}',
                  maxLines: 1,
                  minFontSize: 15,
                  maxFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6),
                    FittedBox(
                      child:
                          Text('Dose: ${widget.userMed.quantity} cápsula(s)'),
                    ),
                    if (widget.userMed.inventory != null) SizedBox(height: 4),
                    if (widget.userMed.inventory != null)
                      FittedBox(
                        child: Text(
                            'Estoque: ${widget.userMed.inventory} cápsula(s)'),
                      ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              trailing: Container(
                width: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => !enableButtons
                            ? null
                            : handleButtonPress(
                                prevOption: option,
                                taken: true,
                                newOption: Option.confirmed,
                              ),
                        child: MedAction(
                            enableButtons ? Colors.green : Colors.grey,
                            Icons.check,
                            option == Option.confirmed),
                      ),
                      GestureDetector(
                        onTap: () => !enableButtons
                            ? null
                            : handleButtonPress(
                                prevOption: option,
                                taken: false,
                                newOption: Option.refused,
                              ),
                        child: MedAction(
                            enableButtons ? Colors.red : Colors.grey,
                            Icons.close,
                            option == Option.refused),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
