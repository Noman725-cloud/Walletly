class Transaction {
  String title;
  double amount;
  String type; // Income or Expense
  String category;
  DateTime date;

  Transaction({
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });
}