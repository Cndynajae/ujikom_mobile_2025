class KanbanResponse {
  bool? success;
  String? message;
  List<Tasks>? tasks;

  KanbanResponse({this.success, this.message, this.tasks});

  KanbanResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int? id;
  String? name;
  String? content;
  int? ownerId;
  int? responsibleId;
  int? statusId;
  int? projectId;
  int? typeId;
  int? priorityId;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Tasks(
      {this.id,
      this.name,
      this.content,
      this.ownerId,
      this.responsibleId,
      this.statusId,
      this.projectId,
      this.typeId,
      this.priorityId,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    ownerId = json['owner_id'];
    responsibleId = json['responsible_id'];
    statusId = json['status_id'];
    projectId = json['project_id'];
    typeId = json['type_id'];
    priorityId = json['priority_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['owner_id'] = this.ownerId;
    data['responsible_id'] = this.responsibleId;
    data['status_id'] = this.statusId;
    data['project_id'] = this.projectId;
    data['type_id'] = this.typeId;
    data['priority_id'] = this.priorityId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
