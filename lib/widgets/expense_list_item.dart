import 'package:flutter/material.dart';
import 'package:from27/models/expense.dart';
import 'package:from27/widgets/expense_list.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;

  const ExpenseListItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
     return Card(
       child: Padding(
           padding: const EdgeInsets.symmetric(
               horizontal: 20,
               vertical: 16
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 '${expense.title}',
                 style: Theme.of(context).textTheme.titleLarge,
               ),
               Row(
                 children: [
                   Text('\$${expense.amount}'),
                   Spacer(),
                   Row(
                     children: [
                       Icon(categoryIcons[expense.category]),
                       SizedBox(width: 8,),
                       Text(expense.FormattedDate)
                     ],
                   )
                 ],
               )
             ],
           ),
       ),
     );
  }
}
