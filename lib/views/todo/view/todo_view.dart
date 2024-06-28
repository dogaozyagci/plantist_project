import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/todo/controller/todo_controller.dart';
import 'package:plantist_project/views/todo/view/reminder_bottom_sheet.dart';
import 'package:plantist_project/views/todo/view/todo_item.dart';

class ToDoPage extends StatelessWidget {
  final ToDoController controller = Get.put(ToDoController());

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
      body: Obx(() {
        if (controller.todoList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.todoList.length,
          itemBuilder: (context, index) {
            return TodoItem(todo: controller.todoList[index]);
          },
        );
      }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (BuildContext context) {
                  return ReminderBottomSheet();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              onPrimary: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              '+ New Reminder ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
