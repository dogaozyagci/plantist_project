import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';

class ToDoController extends GetxController {
  var todoList = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodosToFirestore();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> fetchTodosToFirestore() async {
    final CollectionReference todosCollection = _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection("todolist");

    try {
      final QuerySnapshot snapshot = await todosCollection.get();
      final List<Todo> fetchedTodos = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Todo.fromJson(data, doc.id);
      }).toList();
      todoList.assignAll(fetchedTodos);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteTodoById(String docId) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('todolist')
          .doc(docId)
          .delete();
      fetchTodosToFirestore();
    } catch (e) {
      print('Error: $e');
    }
  }
}
