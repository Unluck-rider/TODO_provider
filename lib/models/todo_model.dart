class Todo {
  final String id;
  final String title;
  final String note;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.note,
    this.isDone = false,
  });
}
