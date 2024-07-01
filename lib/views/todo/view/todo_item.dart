import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:plantist_project/views/core/model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Priority circle
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    width: 24,
                    height: 45,
                    decoration: BoxDecoration(
                      color: _getPriorityColor(todo.priority).withOpacity(0.2),
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
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 3.0),
                  child: SizedBox(
                    width: 200,
                    height: 70,
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
                        const SizedBox(height: 2),
                        //Reminder text
                        Text(
                          todo.note,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black45),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //attachment
                        if (todo.optionalAttachment != null)
                          const Text('📎 Attachment',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black45)),
                      ],
                    ),
                  ),
                ),
                //Date
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy')
                              .format(DateTime.parse(todo.day)),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black45),
                          maxLines: 1,
                        ),
                        Text(
                          todo.hour,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black45),
                        ),
                        //Reminder text
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            height: 1,
            child: FractionallySizedBox(
              widthFactor: 0.86,
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    if (priority == Priority.low.name) {
      return Colors.blue;
    } else if (priority == Priority.medium.name) {
      return Colors.orange;
    } else if (priority == Priority.high.name) {
      return Colors.red;
    } else if (priority == Priority.none.name) {
      return Colors.grey;
    } else
      return Colors.grey;
  }
}
