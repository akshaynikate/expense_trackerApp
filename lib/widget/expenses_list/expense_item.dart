import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(168, 225, 206, 238),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: 4,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₹${expense.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.labelLarge),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat.yMd().format(expense.date),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    //Text(expense.category.name)
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
