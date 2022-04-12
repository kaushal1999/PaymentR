import 'package:expenses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransactions;
  Chart(this.recenttransactions);

  List<Map<String, Object>> get fun {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double sum = 0;
      for (var i = 0; i < recenttransactions.length; i++) {
        if (weekday.day == recenttransactions[i].date.day &&
            weekday.month == recenttransactions[i].date.month &&
            weekday.year == recenttransactions[i].date.year) {
          sum += recenttransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': sum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return fun.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        // child: Text('chart'),
        elevation: 10,
        // margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: fun.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: Bar(
                    e['day'] as String,
                    e['amount'] as double,
                    totalSpending == 0
                        ? 0.0
                        : (e['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ));
  }
}
