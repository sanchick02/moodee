import 'package:flutter/material.dart';
import 'package:moodee/new_forum.dart';
import 'package:moodee/forum_list_.dart';
import 'package:moodee/models/forum.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<ForumScreen> {
  final List<ForumPost> _registeredExpenses = [
    ForumPost(
        id: '', title: 'title', subject: 'subject', topic: 'topic', likes: 0),
    ForumPost(
        id: '', title: 'title', subject: 'subject', topic: 'topic', likes: 0),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewForum(onAddExpense: _addExpense);
        }); //ctx also is a context
  }

  void _addExpense(ForumPost forumPost) {
    setState(() {
      _registeredExpenses.add(forumPost);
    });
  }

  void _removeExpense(ForumPost forumPost) {
    final expenseIndex = _registeredExpenses.indexOf(forumPost);
    setState(() {
      _registeredExpenses.remove(forumPost);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, forumPost);
          });
        },
      ),
    ));
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text('No expense found, Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ForumLists(
        formPosts: _registeredExpenses,
        onRemovePost: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text("Sanjiv's Expense Tracker"),
      ),
      body: Column(
        children: [
          // Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
