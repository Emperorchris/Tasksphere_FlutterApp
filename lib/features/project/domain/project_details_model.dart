import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tasksphere_riverpod/common/models/user_model.dart';
import 'package:tasksphere_riverpod/features/Task/domain/task_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';

class ProjectDetailsModel {
  final ProjectModel projectModel;
  final List<TaskModel> tasks;
  final List<UserModel> teamMembers;
  ProjectDetailsModel({
    required this.projectModel,
    required this.tasks,
    required this.teamMembers,
  });

  ProjectDetailsModel copyWith({
    ProjectModel? projectModel,
    List<TaskModel>? tasks,
    List<UserModel>? teamMembers,
  }) {
    return ProjectDetailsModel(
      projectModel: projectModel ?? this.projectModel,
      tasks: tasks ?? this.tasks,
      teamMembers: teamMembers ?? this.teamMembers,
    );
  }

  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'projectModel': projectModel.toMap()});
    result.addAll({'tasks': tasks.map((x) => x.toMap()).toList()});
    result.addAll({'teamMembers': teamMembers.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory ProjectDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProjectDetailsModel(
      projectModel: ProjectModel.fromMap(map['projectModel']),
      tasks: List<TaskModel>.from(map['tasks']?.map((x) => TaskModel.fromMap(x))),
      teamMembers: List<UserModel>.from(map['teamMembers']?.map((x) => UserModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDetailsModel.fromJson(String source) => ProjectDetailsModel.fromMap(json.decode(source));


  @override
  String toString() => 'ProjectDetailsModel(projectModel: $projectModel, tasks: $tasks, teamMembers: $teamMembers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProjectDetailsModel &&
      other.projectModel == projectModel &&
      listEquals(other.tasks, tasks) &&
      listEquals(other.teamMembers, teamMembers);
  }

  @override
  int get hashCode => projectModel.hashCode ^ tasks.hashCode ^ teamMembers.hashCode;
}
