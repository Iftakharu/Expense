import 'package:flutter/material.dart';
import 'package:from27/enums/Category_enums.dart';
import 'package:from27/models/expense.dart';
import 'package:from27/screens/new_expense.dart';
import 'package:from27/widgets/chart.dart';

import '../widgets/expense_list.dart';

class expense_screen extends StatefulWidget {
  const expense_screen({super.key});

  @override
  State<expense_screen> createState() => _expense_screenState();
}

class _expense_screenState extends State<expense_screen> {

  final List<Expense> _registerExpenses=[
   Expense(
      title: "Job",
      amount: 88,
      date: DateTime.now(),
      category: Expense_category.work,
   ),
    Expense(
      title: "Cinema",
      amount: 99.99,
      date: DateTime.now(),
      category: Expense_category.leisure,
   ),

  ];
  void _openAddExpenseModel(){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx)=> NewExpense(
          onAddExpense: _addExpense,
        ),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense);
    });
  }
  void _removeExpense(Expense expense){
    final expenseIndex=_registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });

    //show undo option and insert if undo clicked
    //Snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: (){
              setState(() {
                _registerExpenses.insert(expenseIndex, expense);
              });

            }),
      )
    );
    
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    print(width);
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseModel,
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registerExpenses,),
          Expanded(
            child:ExpenseList(
              expenses: _registerExpenses,
              onRemoveExpense: _removeExpense,
            ),
          )
        ],
      ),
    );
  }
}
