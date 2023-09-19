class TodolistModel {
  @override
  String toString() {
    return '{tasks: $tasks, pageNumber: $pageNumber, totalPages:$totalPages}';
  }

  List<Tasks>? tasks;
  int? pageNumber;
  int? totalPages;

  TodolistModel({this.tasks, this.pageNumber, this.totalPages});

  TodolistModel.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = pageNumber;
    data['totalPages'] = totalPages;
    return data;
  }
}

class Tasks {
  @override
  String toString() {
    return '{id: $id, title: $title, description: $description, createdAt: $createdAt}, status: $status';
  }

  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? createdAtForGroup;
  String? status;

  Tasks(
      {this.id,
      this.title,
      this.description,
      this.createdAt,
      this.createdAtForGroup,
      this.status});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    createdAtForGroup = json['createdAtForGroup'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['createdAtForGroup'] = createdAtForGroup;
    data['status'] = status;
    return data;
  }
}
