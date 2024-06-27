import 'package:flutter/material.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';
import 'package:plantist_project/views/todo/view/todo_item.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Plantist',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        leadingWidth: 220.0,
        actions: [
          IconButton(
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.search),
            iconSize: 32,
            onPressed: () {
              // todo: Search functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return TodoItem(todo: todoList[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              onPrimary: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              ' New Reminder + ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Todo>todoList = [
  Todo(
    title: 'Morning Jog',
    note: 'Jog for 30 minutes in the park',
    priority: Priority.medium,
    dueDate: DateTime(2024, 7, 1),
    category: 'Exercise',
    tags: ['morning', 'health'],
    optionalAttachment: "iloveyou",
  ),
  Todo(
    title: 'Team Meeting',
    note: 'Discuss project updates and next steps',
    priority: Priority.high,
    dueDate: DateTime(2024, 7, 2, 10, 0),
    category: 'Work',
    tags: ['meeting', 'project'],
    optionalAttachment: 'path/to/meeting/agenda.pdf',
  ),
  Todo(
    title: 'Grocery Shopping',
    note: 'Buy vegetables, fruits, and milk',
    priority: Priority.low,
    dueDate: DateTime(2024, 7, 3),
    category: 'Personal',
    tags: ['shopping', 'groceries'],
    optionalAttachment: "null",
  ),
  Todo(
    title: 'Doctor Appointment',
    note: 'Annual check-up with Dr. Smith',
    priority: Priority.high,
    dueDate: DateTime(2024, 7, 4, 14, 30),
    category: 'Health',
    tags: ['health', 'appointment'],
    optionalAttachment: 'path/to/medical/records.pdf',
  ),
  Todo(
    title: 'Read a Book',
    note: 'Finish reading "The Great Gatsby"',
    priority: Priority.low,
    dueDate: DateTime(2024, 7, 5),
    category: 'Leisure',
    tags: ['reading', 'book'],
    optionalAttachment: "null",
  ),
];
