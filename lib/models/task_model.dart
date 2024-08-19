class TaskModel {
  int? id;
  String title;
  String description;
  bool status;
  DateTime createdDate;
  DateTime dueDate;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status ? 1 : 0,
      'createdDate': createdDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
    };

    return map;
  }

  factory TaskModel.fromMapObject(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'] == 1,
      createdDate: DateTime.parse(map['createdDate']),
      dueDate: DateTime.parse(map['dueDate']),
    );
  }
}
