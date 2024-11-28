import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from27/enums/Category_enums.dart';
import 'package:from27/models/expense.dart';
import 'package:from27/widgets/chart_bar.dart';


class Chart extends StatelessWidget {
  final List<Expense> expenses;
  const Chart({super.key,required this.expenses});

  //buckets
  List<ExpenseBucket> get buckets{
    return [
      ExpenseBucket.forCategory(expenses, Expense_category.leisure),
      ExpenseBucket.forCategory(expenses, Expense_category.food),
      ExpenseBucket.forCategory(expenses, Expense_category.travel),
      ExpenseBucket.forCategory(expenses, Expense_category.work),
    ];
  }

  double get maxTotalExpense{
    double maxTotalExpense=0;
    for(final bucket in buckets){
      if(bucket.totalExpense>maxTotalExpense){
        maxTotalExpense=bucket.totalExpense;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode=MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal:8,vertical: 16 ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(.3),
              Theme.of(context).colorScheme.primary.withOpacity(0),
            ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
        ),
      ),
      child: Column(
        children: [
          //bar
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ChartBar(fill: 0),
                // ChartBar(fill: 0),
                // ChartBar(fill: 0),
                // ChartBar(fill: 0),
                for(final bucket in buckets)
                  ChartBar(
                      fill: bucket.totalExpense==0
                           ? 0
                           : bucket.totalExpense/maxTotalExpense,
                  ),
              ],
            ),
          ),

          SizedBox(height: 32,),
          Expanded(
            child: Row(
              children: buckets.map(
                      (bucket)=>Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4,
                            ),
                          child: Icon(
                            categoryIcons[bucket.category],
                            color: isDarkMode
                                 ? Theme.of(context).colorScheme.secondary
                                 : Theme.of(context).colorScheme.primary.withOpacity(.7),
                          ),
                        ),
                      ),
              ).toList()
            ),
          )
        ],
      ),
    );
  }
}
