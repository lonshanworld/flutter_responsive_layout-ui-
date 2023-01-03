import "package:flutter/material.dart";
import 'package:responsivelayoutWithTransactionapp/chart.dart';
import './newTransaction.dart';
import './transaction_list.dart';
import 'model/transactions.dart';


void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Myhomepage(),
    );
  }
}

class Myhomepage extends StatefulWidget {

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {

  final List<Transaction> _usertransactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions{
    return _usertransactions.where((d){
      return d.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addnewtransaction(String txname, int txprice,DateTime chosenDate){
    final newtx = Transaction(name: txname, price: txprice, id: DateTime.now().toString(), date: chosenDate);

    setState(() {
      _usertransactions.add(newtx);
    });
  }

  void _startAddNewTransactions(BuildContext b){
    showModalBottomSheet(context: b, builder: (bb){
      return GestureDetector(
        child: newTransaction(_addnewtransaction),
      );
    },);
  }

  void _deleteTransaction(String id){
    setState((){
      _usertransactions.removeWhere((g){
        return g.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    final appBar =AppBar(
      title: const Text(
        "Responsive Layout",
      ),
      actions: <Widget>[
        IconButton(
          onPressed: (){
            _startAddNewTransactions(context);
          },
          icon: const Icon(Icons.add) ,
        )
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:[
              Colors.orangeAccent,
              Colors.purpleAccent,
            ],
            stops: [0.3,1.0],
          ),
        ),
      ),
    );

    final txListWidget = SizedBox(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.825,
      child: TransactionList(_usertransactions,_deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if(!isPortrait)Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Show Chart"),
                Switch(
                  activeColor: Colors.purple,
                  inactiveThumbColor: Colors.orange,
                  inactiveTrackColor: Colors.orange.shade200,
                  value: _showChart,
                  onChanged: (m){
                    setState((){
                      _showChart = m;
                    });
                  },
                ),
              ],
            ),
            if(isPortrait)SizedBox(
              height:(mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.26,
              child:  Chart(_recentTransactions),
            ),
            // if(isPortrait)txListWidget,
            if(!isPortrait)_showChart
                ?
            SizedBox(
              height:(mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.6,
              child:  Chart(_recentTransactions),
            )
                :
            Container(),
            txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          _startAddNewTransactions(context);
        },
        elevation: 10,
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

