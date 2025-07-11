import 'package:tasksphere_riverpod/features/Task/domain/task_model.dart';

class TaskResponseDto {
  final Data data;
  final String messsage;

  TaskResponseDto({required this.data, required this.messsage});

  factory TaskResponseDto.fromJson(Map<String, dynamic> json) =>
      TaskResponseDto(
        data: Data.fromJson(json["data"]),
        messsage: json["messsage"],
      );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "messsage": messsage,
  };
}

class Data {
  final String id;
  final String projectId;
  final String description;
  final String status;
  final dynamic startTime;
  final dynamic endTime;
  final dynamic startDate;
  final dynamic endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.projectId,
    required this.description,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    projectId: json["project_id"],
    description: json["description"],
    status: json["status"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_id": projectId,
    "description": description,
    "status": status,
    "start_time": startTime,
    "end_time": endTime,
    "start_date": startDate,
    "end_date": endDate,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  TaskModel toTaskModel() => TaskModel(
    id: id,
    projectId: projectId,
    description: description,
    status: status,
    startTime: startTime,
    endTime: endTime,
    startDate: startDate,
    endDate: endDate,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
