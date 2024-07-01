import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';
import 'package:plantist_project/views/todo/controller/todo_controller.dart';
import 'package:plantist_project/views/todo/view/edit_item_bottom_sheet.dart';
import 'package:plantist_project/views/todo/view/reminder_bottom_sheet.dart';
import 'package:plantist_project/views/todo/view/todo_item.dart';
import 'package:plantist_project/views/todo/view/todo_search.dart';

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
              showSearch(context: context, delegate: TodoSearch(controller));
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.todoList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Filter out todos before today
        DateTime today = DateTime.now();
        List<Todo> filteredTodoList = controller.todoList.where((todo) {
          DateTime todoDate = DateTime.parse(todo.day);
          return todoDate.isAfter(today.subtract(Duration(days: 1)));
        }).toList();

        // Sort filteredTodoList by date
        filteredTodoList.sort((a, b) => DateTime.parse(a.day).compareTo(DateTime.parse(b.day)));

        // Group todos by date
        List<List<Todo>> groupedTodos = [];
        String? lastDay;
        for (var todo in filteredTodoList) {
          DateTime todoDate = DateTime.parse(todo.day);
          String currentDay = '${todoDate.day}.${todoDate.month}.${todoDate.year}';
          if (lastDay != currentDay) {
            lastDay = currentDay;
            groupedTodos.add([todo]);
          } else {
            groupedTodos.last.add(todo);
          }
        }

        return ListView.builder(
          itemCount: groupedTodos.length,
          itemBuilder: (context, groupIndex) {
            List<Todo> todos = groupedTodos[groupIndex];

            // Sort todos by color priority
            todos.sort((a, b) => _getColorPriority(a.priority).compareTo(_getColorPriority(b.priority)));

            String dayTitle = '';
            if (todos.isNotEmpty) {
              DateTime groupDate = DateTime.parse(todos.first.day);
              dayTitle = _getFormattedDayTitle(groupDate);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Text(
                    dayTitle,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Slidable(
                      actionPane: const SlidableDrawerActionPane(),
                      actionExtentRatio: 0.2,
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                              ),
                              builder: (BuildContext context) {
                                return EditItemBottomSheet(todo: todo);
                              },
                            );
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            controller.deleteTodoById(todo.id);
                          },
                        ),
                      ],
                      child: TodoItem(todo: todo),
                    );
                  },
                ),
              ],
            );
          },
        );
      }),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          color: Colors.white,
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

  String _getFormattedDayTitle(DateTime date) {
    DateTime now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day + 1) {
      return 'Tomorrow';
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }

  int _getColorPriority(String name) {
    switch (name) {
      case 'high':
        return 1;
      case 'medium':
        return 2;
      case 'low':
        return 3;
      case 'none':
        return 4;
      default:
        return 5;
    }
  }
}
