import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/newtx.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transactions.dart';

void main() {
  runApp(Myapplication());
}

class Myapplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'expense manager',
      home: Myapp(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                  button: TextStyle(color: Colors.white))),
          accentColor: Colors.yellow,
          primarySwatch: Colors.red),
    );
  }
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List<Transaction> _transactions = [
    Transaction(amount: 100, date: DateTime.now(), id: '1', title: 'shoes'),
    Transaction(amount: 200, date: DateTime.now(), id: '2', title: 'cloth')
  ];
  bool _showchart = false;
  void _addNew(String txtile, DateTime chosenDate, double txamount) {
    final tx = Transaction(
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString(),
        title: txtile);

    setState(() {
      _transactions.add(tx);
    });
  }

  void _startAdd(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNew);
        });
  }

  void _deletetx(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  List<Transaction> get _rtx {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _showLandscapeContent(
      MediaQueryData mediaQuery, AppBar appbar, Widget txlist) {
    return [
      Row(
        children: [
          Text('Show Cart'),
          Switch(
              value: _showchart,
              onChanged: (val) {
                setState(() {
                  _showchart = val;
                });
              })
        ],
      ),
      _showchart
          ? Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_rtx))
          : txlist
    ];
  }

  List<Widget> _showPortraitContent(
      MediaQueryData mediaQuery, AppBar appbar, Widget txlist) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appbar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_rtx)),
      txlist
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appbar = AppBar(
      actions: [
        Builder(
            builder: (context) => IconButton(
                onPressed: () => _startAdd(context), icon: Icon(Icons.add)))
      ],
      title: Text('EXPENSE MANAGER'),
    );
    final txlist = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: TransactionsList(_transactions, _deletetx));
    final islandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: appbar,
      body: ListView(children: [
        if (!islandscape) ..._showPortraitContent(mediaQuery, appbar, txlist),
        if (islandscape) ..._showLandscapeContent(mediaQuery, appbar, txlist)
      ]),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _startAdd(context),
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
