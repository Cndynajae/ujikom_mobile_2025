class KanbanResponse {
  bool? success;
  String? message;
  List<Task>? tasks;

  KanbanResponse({this.success, this.message, this.tasks});

  factory KanbanResponse.fromJson(Map<String, dynamic> json) {
    return KanbanResponse(
      success: json['success'],
      message: json['message'],
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((task) => Task.fromJson(task))
          .toList(),
    );
  }
}

class Task {
  int? id;
  String? name;
  String? content;
  int? ownerId;
  int? responsibleId;
  int? statusId;
  Status? status; // Tambahkan ini
  int? projectId;
  int? typeId;
  int? priorityId;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Task({
    this.id,
    this.name,
    this.content,
    this.ownerId,
    this.responsibleId,
    this.statusId,
    this.status,
    this.projectId,
    this.typeId,
    this.priorityId,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      content: json['content'],
      ownerId: json['owner_id'],
      responsibleId: json['responsible_id'],
      statusId: json['status_id'],
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      projectId: json['project_id'],
      typeId: json['type_id'],
      priorityId: json['priority_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Status {
  int? id;
  String? name;
  String? color;

  Status({
    this.id,
    this.name,
    this.color,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
