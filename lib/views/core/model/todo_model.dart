class Todo {
  String title;
  String note;
  Priority priority;
  DateTime dueDate;
  String category;
  List<String> tags;
  String? optionalAttachment;

  Todo({
    required this.title,
    required this.note,
    required this.priority,
    required this.dueDate,
    required this.category,
    required this.tags,
    this.optionalAttachment,
  });
}

enum Priority {
  none,
  low,
  medium,
  high,
}
