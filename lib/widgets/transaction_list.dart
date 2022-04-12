import 'package:expenses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> list;
  final Function delete;
  TransactionsList(this.list, this.delete);

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'no transactions added yet!',
                  style: ThemeData.light().textTheme.title,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/536.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : Container(
            height: 300,
            child: ListView(
                children: list
                    .map((e) => TransactionItem(
                        key: ValueKey(e.id), item: e, delete: delete))
                    .toList()),
          );
  }
}
