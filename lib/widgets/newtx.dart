import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function add;
  NewTransaction(this.add);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime? pickeddate;

  void _submitdata() {
    final inputtitle = titlecontroller.text;
    final inputamount = double.parse(amountcontroller.text);
    if (inputtitle.isEmpty || inputamount <= 0 || pickeddate == null) {
      return;
    }

    widget.add(
        inputtitle, pickeddate, double.parse(inputamount.toStringAsFixed(2)));
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          pickeddate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        // elevation: 15,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          // color: Colors.amber,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titlecontroller,
                onSubmitted: (_) => _submitdata(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitdata(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(pickeddate == null
                          ? 'No date choosen!'
                          : 'Picked date: ${DateFormat('dd-MMM-yyyy').format(pickeddate as DateTime)}'),
                    ),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: _submitdata,
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Add transaction',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
