import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodee/models/forum.dart';

final formatted = DateFormat.yMd();

class NewForum extends StatefulWidget {
  const NewForum({super.key, required this.onAddExpense});

  final void Function(ForumPost forumPost) onAddExpense;
  @override
  State<NewForum> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewForum> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  // Categories _selectedCategory = Categories.leisure;

  void presentDatePicker() async {
    //either async & await or then value
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure a valid title,amount,date and category was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(ForumPost(
      id: '',
      title: _titleController.text,
      subject: _amountController.text,
      topic: _selectedDate.toString(),
      likes: 0,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date Selected'
                          : formatted.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              // DropdownButton(
              //     value: _selectedCategory,
              //     items: Categories.values
              //         .map(
              //           (category) => DropdownMenuItem(
              //             value: category,
              //             child: Text(category.name.toUpperCase()),
              //           ),
              //         )
              //         .toList(),
              //     onChanged: (value) {
              //       setState(
              //         () {
              //           if (value == null) {
              //             return;
              //           }
              //           _selectedCategory = value;
              //         },
              //       );
              //     }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save Expense'))
            ],
          ),
        ],
      ),
    );
  }
}
