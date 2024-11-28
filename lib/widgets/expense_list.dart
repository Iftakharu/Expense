import 'package:flutter/material.dart';
import 'package:from27/models/expense.dart';
import 'package:from27/widgets/expense_list_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpenseList({super.key, required this.expenses,required this.onRemoveExpense});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:  expenses.length,
      itemBuilder: (context,index)=> Dismissible(
          key: ValueKey(expenses[index]), //mandatory
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          onDismissed: (direction){
             onRemoveExpense(expenses[index]);
          },
          child: ExpenseListItem(expense: expenses[index])),
    );
  }
}