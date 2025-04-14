class ProjectResponse {
  bool? success;
  String? message;
  List<Projects>? projects;

  ProjectResponse({this.success, this.message, this.projects});

  ProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Projects {
  int? id;
  String? name;
  String? description;
  int? ownerId;
  int? statusId;
  String? ticketPrefix;
  String? coverImage;
  String? createdAt;
  String? updatedAt;
  Owner? owner;
  Status? status;
  List<Tasks>? tasks;

  Projects(
      {this.id,
      this.name,
      this.description,
      this.ownerId,
      this.statusId,
      this.ticketPrefix,
      this.coverImage,
      this.createdAt,
      this.updatedAt,
      this.owner,
      this.status,
      this.tasks});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    ownerId = json['owner_id'];
    statusId = json['status_id'];
    ticketPrefix = json['ticket_prefix'];
    coverImage = json['cover_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['owner_id'] = this.ownerId;
    data['status_id'] = this.statusId;
    data['ticket_prefix'] = this.ticketPrefix;
    data['cover_image'] = this.coverImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? name;
  String? nrp;
  String? email;
  Null? emailVerifiedAt;
  int? isActive;
  Null? departementId;
  Null? jabatanId;
  Null? bagianId;
  Null? avatar;
  String? createdAt;
  String? updatedAt;

  Owner(
      {this.id,
      this.name,
      this.nrp,
      this.email,
      this.emailVerifiedAt,
      this.isActive,
      this.departementId,
      this.jabatanId,
      this.bagianId,
      this.avatar,
      this.createdAt,
      this.updatedAt});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nrp = json['nrp'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isActive = json['is_active'];
    departementId = json['departement_id'];
    jabatanId = json['jabatan_id'];
    bagianId = json['bagian_id'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nrp'] = this.nrp;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_active'] = this.isActive;
    data['departement_id'] = this.departementId;
    data['jabatan_id'] = this.jabatanId;
    data['bagian_id'] = this.bagianId;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Status {
  int? id;
  String? name;
  String? color;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  Status(
      {this.id,
      this.name,
      this.color,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  String? code;
  int? order;
  int? estimation;
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
      this.code,
      this.order,
      this.estimation,
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
    code = json['code'];
    order = json['order'];
    estimation = json['estimation'];
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
    data['code'] = this.code;
    data['order'] = this.order;
    data['estimation'] = this.estimation;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
