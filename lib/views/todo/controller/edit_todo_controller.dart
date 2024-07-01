import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';
import 'package:plantist_project/views/todo/controller/todo_controller.dart';

class EditTodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ToDoController todoController = Get.put(ToDoController());


  var title = ''.obs;
  var note = ''.obs;
  var priority = 'none'.obs;
  var isCalendarEnabled = false.obs;
  var isTimeEnabled = false.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay(hour: 12, minute: 00).obs;


  void updateTitle(String newTitle) {
    title.value = newTitle;
  }

  void updateNotes(String newNote) {
    note.value = newNote;
  }

  void updatePriority(String newPriority) {
    priority.value = newPriority;
  }

  void updateCalendarEnabled(bool value) {
    isCalendarEnabled.value = value;
  }

  void updateTimeEnabled(bool value) {
    isTimeEnabled.value = value;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateSelectedTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  void initTodo(Todo todo){
    title = todo.title.obs;
    note = todo.note.obs;
    priority = todo.priority.obs;
  }

  Future<void> updateUserToFirestore(Todo todo) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection("todolist")
          .doc(todo.id)
          .set(todo.toJson());
      clearData();
      todoController.fetchTodosToFirestore();
    } catch (e) {
      print('Error: $e');
    }
  }

  String formatTimeHour(int hour, int minute) {
    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }

  void clearData() {
    title = ''.obs;
    note = ''.obs;
    priority = 'none'.obs;
    isCalendarEnabled = false.obs;
    isTimeEnabled = false.obs;
    selectedDate = DateTime.now().obs;
    selectedTime = TimeOfDay(hour: 12, minute: 00).obs;
  }
}
