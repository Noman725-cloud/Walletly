import 'package:expense_tracker/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.fastfood, 'label': 'Food'},
    {'icon': Icons.flight, 'label': 'Travel'},
    {'icon': Icons.home, 'label': 'Bills'},
    {'icon': Icons.shopping_cart, 'label': 'Shopping'},
    {'icon': Icons.movie, 'label': 'Entertainment'},
    {'icon': Icons.healing, 'label': 'Health'},
    {'icon': Icons.attach_money, 'label': 'salary'},
    {'icon': Icons.emoji_transportation, 'label': 'Transportation'}
  ];

  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;
  final List<String> _transactionType = [
    'Income',
    'Expense'
  ];
  String _selectedTransactionType = '';

  void _handleSaveTransaction() {
    if (_formKey.currentState!.validate() &&
        _selectedCategory != null &&
        _selectedTransactionType.isNotEmpty) {

      final newTransaction = Transaction(
        title: titleController.text,
        amount: double.parse(amountController.text),
        type: _selectedTransactionType,
        category: _selectedCategory!,
        date: _selectedDate,
      );

      Navigator.pop(context, newTransaction);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transactions')),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return "Enter a title";
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return "Enter an amount";
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Type',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          // value: _selectedTransactionType,
                          items:
                          _transactionType
                                  .map(
                                    (type) => DropdownMenuItem(
                                      value: type,
                                      child: Text(type),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) => _selectedTransactionType = value!,
                        ),
                        const SizedBox(height: 25),

                        const Text(
                          "Select Category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          children:
                              _categories.map((category) {
                                return ChoiceChip(
                                  avatar: Icon(category['icon']),
                                  label: Text(category['label']),
                                  selected:
                                      _selectedCategory == category['label'],
                                  onSelected:
                                      (_) => setState(() {
                                        _selectedCategory = category['label'];
                                      }),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Date:',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),

                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          title: Text(
                            DateFormat.yMMMd().format(_selectedDate),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 50),

                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ),
                              onPressed: _handleSaveTransaction,
                              child: Text(
                                'Save Transaction',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
