import 'package:farma_segura_app/providers/selected_date.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

import './date_item.dart';

class DateSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final date = Provider.of<SelectedDate>(context).date;
    String monthYear = DateFormat(DateFormat.YEAR_MONTH, 'pt_BR').format(date);
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 0, left: 3, right: 3),
      child: Column(
        children: [
          Container(
            child: FittedBox(
              child: Text(
                "${monthYear[0].toUpperCase()}${monthYear.substring(1)}",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
          Container(
            width: mediaQuery.size.width,
            height: 85,
            child: InfiniteListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var itemDate = DateTime.now().add(Duration(days: index - 2));
                return DateItem(itemDate);
              },
            ),
          ),
        ],
      ),
    );
  }
}
