class Task {
  final int? id;
  final String? title;
  String? description;

  Task({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
