import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx,constraints){
            return  Center(
              child: Column(
                children: [
                  Text(
                    'No transactions!!',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.5,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              ),
            );
      })


          : ListView.builder(
              itemBuilder: (ctx, index) {
                // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         padding: EdgeInsets.all(10),
                //         margin:
                //         const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //               color: Theme
                //                   .of(context)
                //                   .primaryColorLight,
                //               width: 2,
                //             )),
                //         child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                //           style: const TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //             color: Colors.redAccent,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: const TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           Text(
                //             DateFormat.yMMMd().format(transactions[index].date),
                //             style: const TextStyle(
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360 ?
                        FlatButton.icon(onPressed: () => deleteTx(transactions[index].id), icon: Icon(Icons.delete), label: Text("Delete"))
                        :IconButton(icon: Icon(Icons.delete),
                    color: Colors.redAccent, onPressed: () => deleteTx(transactions[index].id),),
                  ),

                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
