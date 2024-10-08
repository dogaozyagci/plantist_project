import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';
import 'package:plantist_project/views/todo/controller/edit_todo_controller.dart';

class EditItemBottomSheet extends StatelessWidget {
  final EditTodoController controller = Get.put(EditTodoController());
  final Todo todo;

  EditItemBottomSheet({required this.todo});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.75;
    controller.initTodo(todo);

    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // cancel & title & save
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Text(
                    'Edit Page',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Todo newTodo = Todo(
                          id: todo.id,
                          title: controller.title.value,
                          note: controller.note.value,
                          priority: controller.priority.value,
                          day: controller.selectedDate.value.toString(),
                          hour: controller.formatTimeHour(
                              controller.selectedTime.value.hour,
                              controller.selectedTime.value.minute),
                          category: "",
                          tags: [],
                          optionalAttachment: "");
                      controller.updateUserToFirestore(newTodo);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // title text
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextField(
                    onChanged: controller.updateTitle,
                    controller: TextEditingController(text: todo.title),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ),
                // notes text
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 8.0),
                  child: TextField(
                    onChanged: controller.updateNotes,
                    controller: TextEditingController(text: todo.note),
                    maxLines: 2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ),
                // date
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('📆 Date', style: TextStyle(fontSize: 16)),
                        Obx(() => CupertinoSwitch(
                              value: controller.isCalendarEnabled.value,
                              onChanged: (value) {
                                controller.updateCalendarEnabled(value);
                                if (value) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      DateTime tempPickedDate = DateTime.now();
                                      return SizedBox(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 230,
                                              child: CupertinoDatePicker(
                                                initialDateTime: DateTime.now(),
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  tempPickedDate = newDateTime;
                                                },
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.updateSelectedDate(
                                                    tempPickedDate);
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              child: const Text('Tamam'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                // time
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('⏰ Time', style: TextStyle(fontSize: 16)),
                      Obx(() => CupertinoSwitch(
                            value: controller.isTimeEnabled.value,
                            onChanged: (value) async {
                              controller.updateTimeEnabled(value);
                              if (value) {
                                final pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: controller.selectedTime.value,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.black,
                                        ),
                                        buttonTheme: const ButtonThemeData(
                                            textTheme: ButtonTextTheme.primary),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickedTime != null) {
                                  controller.updateSelectedTime(pickedTime);
                                } else {
                                  controller.updateSelectedTime(
                                      const TimeOfDay(hour: 12, minute: 0));
                                }
                              }
                            },
                          )),
                    ],
                  ),
                ),
                // priority
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          double height =
                              MediaQuery.of(context).size.height * 0.75;
                          return SizedBox(
                            height: height,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                ListTile(
                                  title: const Text('None'),
                                  onTap: () {
                                    controller.updatePriority('none');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Low'),
                                  onTap: () {
                                    controller.updatePriority('low');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Medium'),
                                  onTap: () {
                                    controller.updatePriority('medium');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('High'),
                                  onTap: () {
                                    controller.updatePriority('high');
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      side: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Priority',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(todo.priority,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // attach file
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      side: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Attach a file',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('None 📎',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
