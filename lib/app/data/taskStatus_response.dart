class TaskstatusResponse {
	bool? success;
	String? message;
	List<TaskStatus>? taskStatus;

	TaskstatusResponse({this.success, this.message, this.taskStatus});

	TaskstatusResponse.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		message = json['message'];
		if (json['taskStatus'] != null) {
			taskStatus = <TaskStatus>[];
			json['taskStatus'].forEach((v) { taskStatus!.add(new TaskStatus.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = this.success;
		data['message'] = this.message;
		if (this.taskStatus != null) {
      data['taskStatus'] = this.taskStatus!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TaskStatus {
	int? id;
	String? name;
	String? color;
	int? isDefault;
	int? order;
	String? createdAt;
	String? updatedAt;

	TaskStatus({this.id, this.name, this.color, this.isDefault, this.order, this.createdAt, this.updatedAt});

	TaskStatus.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		color = json['color'];
		isDefault = json['is_default'];
		order = json['order'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['color'] = this.color;
		data['is_default'] = this.isDefault;
		data['order'] = this.order;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		return data;
	}
}
