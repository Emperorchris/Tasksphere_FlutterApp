import 'dart:convert';

class TaskModel {
  final String id;
  final String projectId;
  final String description;
  final String status;
  final String? startTime;
  final String? endTime;
  final String? startDate;
  final String? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  TaskModel({
    required this.id,
    required this.projectId,
    required this.description,
    required this.status,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  TaskModel copyWith({
    String? id,
    String? projectId,
    String? description,
    String? status,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      description: description ?? this.description,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'projectId': projectId});
    result.addAll({'description': description});
    result.addAll({'status': status});
    if(startTime != null){
      result.addAll({'startTime': startTime});
    }
    if(endTime != null){
      result.addAll({'endTime': endTime});
    }
    if(startDate != null){
      result.addAll({'startDate': startDate});
    }
    if(endDate != null){
      result.addAll({'endDate': endDate});
    }
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'updatedAt': updatedAt.millisecondsSinceEpoch});
  
    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      projectId: map['projectId'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      startTime: map['startTime'],
      endTime: map['endTime'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, projectId: $projectId, description: $description, status: $status, startTime: $startTime, endTime: $endTime, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TaskModel &&
      other.id == id &&
      other.projectId == projectId &&
      other.description == description &&
      other.status == status &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      projectId.hashCode ^
      description.hashCode ^
      status.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
