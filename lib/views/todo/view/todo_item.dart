import 'package:flutter/material.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  TodoItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Priority circle
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 24,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _getPriorityColor(todo.priority).withOpacity(0.5),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _getPriorityColor(todo.priority),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                //Title & note
                Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3),
                      child: Container(
                        width: 200,
                        height: 95,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo.title,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            //Reminder text
                            Text(
                              todo.note,
                              style: TextStyle(fontSize: 13, color: Colors.black45),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (todo.optionalAttachment != null)
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('📎 Attachment',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black45)),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                //Date
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${todo.dueDate}',
                          style: TextStyle(fontSize: 14, color: Colors.black45),
                          maxLines: 1,
                        ),
                        Text(
                          '${todo.dueDate.hour}:${todo.dueDate.minute}:${todo.dueDate.second}',
                          style: TextStyle(fontSize: 14, color: Colors.black45),
                        ),

                        //Reminder text
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.blue;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
      case Priority.none:
        return Colors.grey;
    }
  }
}
