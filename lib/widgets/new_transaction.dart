import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (amount.text.isEmpty) {
      return;
    }
    final enteredTitle = title.text;
    final enteredAmount = num.parse(amount.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addtx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2019),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((val) {
      if (val == null) {
        return;
      }
      setState(() {
        _selectedDate = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: title,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  //onChanged: (val) => amount=val,
                  controller: amount,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _selectedDate == null
                            ? Text('No Date Chosen!')
                            : Text('Picked Date : ' +
                                DateFormat.yMMMd().format(_selectedDate)),
                      ),
                      FlatButton(
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        onPressed: _presentDatePicker,
                      )
                    ],
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.purple,
                  onPressed: _submitData,
                )
              ]),
        ),
      ),
    );
  }
}
