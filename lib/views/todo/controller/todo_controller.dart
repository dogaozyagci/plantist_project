import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/core/model/todo_model.dart';

class ToDoController extends GetxController {
  var todoList = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodosDummy();
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> fetchTodosDummy() async {
    final CollectionReference todosCollection = firestore.collection('users/y68lyWcomWIJXGrWNxmz/todolist');

    try {
      final QuerySnapshot snapshot = await todosCollection.get();
      final List<Todo> fetchedTodos = snapshot.docs.map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>)).toList();
      todoList.assignAll(fetchedTodos);
    } catch (e) {
      print('Hata: $e');
    }
  }

  /*void fetchTodos() {
    // This is where you would normally fetch data from a database or API
    var fetchedTodos = [
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
    todoList.addAll(fetchedTodos);
  }*/
}
