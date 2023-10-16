import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemove});
  final List<Expense> expenses;
  final void Function(Expense exp) onRemove;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
          background: Container(
            //margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.6),
            ),
            child: Text(
              'Deleting...',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          onDismissed: (direction) => onRemove(expenses[index]),
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}
