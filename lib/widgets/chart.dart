import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/new_chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String,Object>> get groupedtransactionsValue{
    return List.generate(7,(index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var totalSum = 0.0;
      for (var i =0; i<recentTransactions.length; i++){
        if(recentTransactions[i].date.day == weekDay.day &&
          recentTransactions[i].date.month == weekDay.month &&
          recentTransactions[i].date.year == weekDay.year
        ){
          print(recentTransactions[i].amount);
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay).substring(0,1));
      print(totalSum);
      return {"Day":DateFormat.E().format(weekDay).substring(0,1),"amount":totalSum};
    }).reversed.toList();
  }

  double get maxSpending{
    return groupedtransactionsValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedtransactionsValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedtransactionsValue.map((data){
           return Flexible(
             fit: FlexFit.tight,
             child: ChartBar( data['Day'] as String,
                 data['amount'] as double,
                 maxSpending== 0.0? 0.0: (data['amount'] as double)/ maxSpending),
           );
          }).toList(),
        ),
      ),
    );
  }
}
