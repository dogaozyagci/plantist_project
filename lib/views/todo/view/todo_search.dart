import 'package:flutter/material.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';
import 'package:plantist_project/views/todo/controller/todo_controller.dart';

class TodoSearch extends SearchDelegate<Todo> {
  final ToDoController controller;

  TodoSearch(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Todo> results = controller.todoList
        .where((todo) => todo.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final todo = results[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.day),
          onTap: () {
            close(context, todo);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Todo> suggestions = controller.todoList
        .where((todo) => todo.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final todo = suggestions[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.day),
          onTap: () {
            query = todo.title;
            showResults(context);
          },
        );
      },
    );
  }
}
