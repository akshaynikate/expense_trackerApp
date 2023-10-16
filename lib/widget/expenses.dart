import 'package:expense_tracker/widget/chart.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:expense_tracker/widget/expenses_list/expense_list.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 499.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Breakfast',
        amount: 120,
        date: DateTime.now(),
        category: Category.food),
    //  Expense(
    //      title: 'Went to pune',
    //      amount: 2200,
    //      date: DateTime.now(),
    //      category: Category.travel),
    //  Expense(
    //      title: 'T-shirt',
    //      amount: 350,
    //      date: DateTime.now(),
    //      category: Category.personal),
  ];
  void _openAddExpenseForm() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense exp) {
    setState(() {
      _registeredExpenses.add(exp);
    });
  }

  void _removeExpense(Expense exp) {
    final expIndex = _registeredExpenses.indexOf(exp);
    setState(() {
      _registeredExpenses.remove(exp);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expIndex, exp);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print('height${height}');
    print('width${width}');
    Widget mainContent = const Center(
      child: Text('NO Expenses Added!!!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemove: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        //style: GoogleFonts.lora(
        //  color: Colors.white,
        //)),

        actions: [
          IconButton(
            onPressed: _openAddExpenseForm,
            icon: const Icon(Icons.add), //color: Colors.white),
          ),
        ],
      ),
      body: width < 400
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                mainContent,
              ],
            )
          : Row(children: [
              Expanded(child: Chart(expenses: _registeredExpenses)),
              mainContent,
            ]),
    );
  }
}
