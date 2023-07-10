class Task {
  int? id;
  String title;
  String description;
  int isDone;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isDone = 0,
  });


  Task copyWith({
    int? id,
    String? title,
    String? description,
    int? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Task copyWithMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as int,
    );
  }

}
