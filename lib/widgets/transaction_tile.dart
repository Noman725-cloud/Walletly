import 'package:expense_tracker/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  TransactionTile({
    super.key, required this.transaction,
  });

  final Map<String, IconData> categoryIcons = {
    'Food': Icons.fastfood,
    'Travel': Icons.flight,
    'Bills': Icons.home,
    'Shopping': Icons.shopping_cart,
    'Entertainment': Icons.movie,
    'Health': Icons.healing,
    'salary': Icons.attach_money,
    'Transportation': Icons.emoji_transportation,
  };

  @override
  Widget build(BuildContext context) {
    final icon = categoryIcons[transaction.category] ?? Icons.category;
    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(transaction.title),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: Text('${transaction.type == 'Expense' ? '-' : '+'}৳${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: transaction.type == 'Expense' ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
        ),
        )
      ),
    );
  }
}