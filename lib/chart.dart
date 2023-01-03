import "package:flutter/material.dart";
import "package:intl/intl.dart";

import 'model/transactions.dart';
import "./chartbar.dart";

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0;
      for(var i=0; i < recentTransactions.length; i++){
        if(recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year){
          totalSum += recentTransactions[i].price;
        }
      }

      return {
        "day":DateFormat.MMMd().format(weekday),
        "amount": totalSum.toDouble(),
      };
    }).reversed.toList();
  }

   double get totalSpending{
    return groupedTransactionValues.fold(0, (sum,item) {
      return sum +( item["amount"] as double) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      // margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data["day"] as String,
                data["amount"] as double,
                totalSpending == 0 ? 0 :( data["amount"] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
