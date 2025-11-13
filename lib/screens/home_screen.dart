import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/screens/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/transaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> transactions = [];

  double get totalBalance => transactions.fold(0.0, (sum, tx) {
    return tx.type == 'Income' ? sum + tx.amount : sum - tx.amount;
  });

  double get totalIncome => transactions
      .where((tx) => tx.type == 'Income')
      .fold(0.0, (sum, tx) => sum + tx.amount);

  double get totalExpense => transactions
      .where((tx) => tx.type == 'Expense')
      .fold(0.0, (sum , tx) => sum + tx.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walletly'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "৳$totalBalance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Income: \n৳$totalIncome",
                          style: TextStyle(
                            color: Color(0xFF00C853),
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          "Expense: \n৳$totalExpense",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Color(0xFF1E1E1E),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTransactionScreen(),
                      ),
                    );

                    if (result != null && result is Transaction) {
                      setState(() {
                        transactions.add(result);
                      });
                    }
                  },

                  label: Text(
                    "Add Income",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  icon: Icon(Icons.attach_money, size: 20.sp),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Color(0xFF1E1E1E),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTransactionScreen(),
                      ),
                    );

                    if (result != null && result is Transaction) {
                      setState(() {
                        transactions.add(result);
                      });
                    }
                  },

                  label: Text(
                    "Add Expense",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.do_not_disturb_on,
                    color: Colors.redAccent,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionTile(transaction: transactions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
