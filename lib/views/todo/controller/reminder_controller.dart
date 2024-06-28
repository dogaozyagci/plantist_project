import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';

class ReminderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var title = ''.obs;
  var note = ''.obs;
  var priority = 'none'.obs;
  var isCalendarEnabled = false.obs;
  var isTimeEnabled = false.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = const TimeOfDay(hour: 12, minute: 0).obs;


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
    selectedTime.value = time ;
  }



  Future<void> addUserToFirestore(Todo todo) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection("todolist")
          .add(todo.toJson());
      print('Todo added successfully!');
    } catch (e) {
      print('Error adding todo: $e');
    }
  }

}