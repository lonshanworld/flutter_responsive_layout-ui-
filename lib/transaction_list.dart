import "package:flutter/material.dart";
import 'model/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ?
      LayoutBuilder(builder: (n,p){
        return Container(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                "No Transaction Added Yet!!!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: p.maxHeight * 0.6,
                child: Image.asset("assets/images/running-stickman.gif", fit: BoxFit.cover,),
              )
            ],
          ),
        );
      })
          :
      ListView.builder(
        itemBuilder: (a,index){
          return Card(
            color: Colors.white,
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${transactions[index].price} Ks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple.shade200,
                  ),
                ),
              ),
              title: Text(
                transactions[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              subtitle:Text(
                DateFormat.yMMMd().format(transactions[index].date),
                style:const TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteTx(transactions[index].id) ,
              ),
            ),
          );
        },
        itemCount: transactions.length,
      );
  }
}

