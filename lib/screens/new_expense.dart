import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from27/enums/Category_enums.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key,required this.onAddExpense,});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  final _titleController=TextEditingController();
  final _amountController=TextEditingController();

  DateTime? _selectedDate;
  Expense_category _selectedCategory=Expense_category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async{
    final now=DateTime.now();
    final first_date=DateTime(now.year-1,now.month,now.day);
    final pickedDate= await showDatePicker(context: context,
        initialDate: now,
        firstDate: first_date,
        lastDate: now
    );
    setState(() {
      _selectedDate=pickedDate;
    });
  }

  void _submitExpenseData(){
    final enteredAmount=double.tryParse(_amountController.text);
    final amountIsInvalid=enteredAmount==null || enteredAmount<=0;
    //check all input

    if(_titleController.text.trim().isEmpty||amountIsInvalid||_selectedDate==null){
      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title: Text('Invalid Input'),
        content: Text('Please make sure you have entered valid title,amount,category and date'),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
        ],
      )
      );
      return;
    }
    widget.onAddExpense(
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory
        )
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,

            decoration: InputDecoration(
              label: Text('Title')
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount')
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Text(
                      _selectedDate==null?
                      'No Date Selected'
                      :formatter.format(_selectedDate!)
              ),
              IconButton(
                  onPressed:_presentDatePicker,
                  icon: Icon(Icons.calendar_month)),

            ],
          ),


          
          Row(
            children: [
              DropdownButton(
                  value:_selectedCategory,
                  items:Expense_category.values.map((category)=> DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()))).toList(),
                  onChanged: (value){
                    if(value==null){
                      return;
                    }
                    setState(() {
                      _selectedCategory=value;
                    });
                  },
              ),
              Spacer(),
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel')),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: Text('Save Expense'))
            ],
          )
        ],
      ),

    );
  }
}
