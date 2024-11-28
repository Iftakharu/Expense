import 'package:flutter/material.dart';
import 'package:from27/enums/Category_enums.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter=DateFormat.yMd();

const categoryIcons={
Expense_category.leisure:Icons.movie,
Expense_category.work:Icons.work,
Expense_category.travel:Icons.train,
Expense_category.food:Icons.lunch_dining,
};

class Expense{
  static const uuid= Uuid();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Expense_category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }): id=uuid.v4();

  String get FormattedDate{
    return formatter.format(date);
  }
}

class ExpenseBucket{
  final Expense_category category;
  final List<Expense> expenses;
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category)
  : expenses=allExpenses
      .where((expense)=>expense.category==category)
      .toList();

  double get totalExpense{
    double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;
    }
    return sum;
  }
}

