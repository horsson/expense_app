import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adapative_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) addTx;

  NewTransaction(this.addTx) {
    print("Constructor method is called NewTransaction.");
  }

  @override
  _NewTransactionState createState() {
    print("CreateState is called NewTransaction");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  @override
  void initState() {
    print("initState is called NewTransaction");
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print("didUpdateWidget is called NewTransaction");
    super.didUpdateWidget(oldWidget);
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate != null
                        ? DateFormat.yMd().format(_selectedDate)
                        : 'No Date Chosen!'),
                  ),
                  AdaptiveFlatButton("Choose Date", _presentDatePicker),
                ],
              ),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
              color: Colors.purple,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
