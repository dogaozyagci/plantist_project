class Todo {
  final String title;
  final String note;
  final String priority;
  final String day;
  final String hour;
  final String category;
  final List<String> tags;
  final String optionalAttachment;

  Todo({
    required this.title,
    required this.note,
    required this.priority,
    required this.day,
    required this.hour,
    required this.category,
    required this.tags,
    required this.optionalAttachment,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] ?? "",
      note: json['note'] ?? "",
      priority: json['priority'] ?? "",
      day: json['day'] ?? "",
      hour: json['hour'] ?? "",
      category: json['category'] ?? "",
      tags: List<String>.from(json['tags']) ?? [],
      optionalAttachment: json['optionalAttachment'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'priority': priority,
      'day': day,
      'hour': hour,
      'category': category,
      'tags': tags,
      'optionalAttachment': optionalAttachment,
    };
  }
}

enum Priority {
  none,
  low,
  medium,
  high,
}
