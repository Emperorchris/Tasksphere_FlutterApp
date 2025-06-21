import 'dart:convert';

class ProjectModel {
  final String? id;
  final String? adminId;
  final String? name;
  final String? image;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? completionPercentage;
  final ProjectStatus? status;
  ProjectModel({
    this.id,
    this.adminId,
    this.name,
    this.image,
    this.description,
    this.startDate,
    this.endDate,
    this.completionPercentage,
    this.status,
  });

  ProjectModel copyWith({
    String? id,
    String? adminId,
    String? name,
    String? image,
    String? description,
    String? startDate,
    String? endDate,
    String? completionPercentage,
    ProjectStatus? status,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      adminId: adminId ?? this.adminId,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      status: status ?? this.status,
    );
  }



  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(adminId != null){
      result.addAll({'adminId': adminId});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(image != null){
      result.addAll({'image': image});
    }
    if(description != null){
      result.addAll({'description': description});
    }
    if(startDate != null){
      result.addAll({'startDate': startDate});
    }
    if(endDate != null){
      result.addAll({'endDate': endDate});
    }
    if(completionPercentage != null){
      result.addAll({'completionPercentage': completionPercentage});
    }
    if(status != null){
      result.addAll({'status': status!.name});
    }
  
    return result;
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      adminId: map['adminId'],
      name: map['name'],
      image: map['image'],
      description: map['description'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      completionPercentage: map['completionPercentage'],
      status: map['status'] != null ? ProjectStatus.values.firstWhere((e) => e.name == map['status']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) => ProjectModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateProjectModel(id: $id, adminId: $adminId, name: $name, image: $image, description: $description, startDate: $startDate, endDate: $endDate, completionPercentage: $completionPercentage, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProjectModel &&
      other.id == id &&
      other.adminId == adminId &&
      other.name == name &&
      other.image == image &&
      other.description == description &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.completionPercentage == completionPercentage &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      adminId.hashCode ^
      name.hashCode ^
      image.hashCode ^
      description.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      completionPercentage.hashCode ^
      status.hashCode;
  }
}

enum ProjectStatus { upcoming, inProgress, completed }
