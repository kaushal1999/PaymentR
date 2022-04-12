import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transactions.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.item,
    required this.delete,
  }) : super(key: key);

  final Transaction item;
  final Function delete;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgcolor;
  @override
  void initState() {
    const availableColors = [Colors.amber, Colors.black, Colors.blue];
    _bgcolor = availableColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgcolor,
            radius: 30,
            child: FittedBox(child: Text('\$${widget.item.amount}')),
          ),
          title: Text(
            widget.item.title,
          ),
          subtitle: Text(DateFormat('dd-MMM-yyyy').format(widget.item.date)),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  onPressed: () => widget.delete(widget.item.id),
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => widget.delete(widget.item.id),
                  color: Theme.of(context).errorColor,
                ),
        ),
      ),
    );
  }
}
