import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  var  selectedDate;

  void submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount= double.parse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount<=0 || selectedDate == null){
      return;
    }
    widget.addTx(enteredTitle,enteredAmount,selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),).then((pickedDate) {
          if(pickedDate== null){
            return;
          }else{
            setState(() {
            selectedDate = pickedDate;

            });
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (val) => titleInput = val,
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                //onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: Text(selectedDate == null?"No date chosen": DateFormat.yMd().format(selectedDate))),
                    FlatButton(
                      textColor: Colors.redAccent,
                      onPressed: presentDatePicker,
                        child: Text("Choose Date",style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: submitData,
                child: Text("Add Transaction"),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
