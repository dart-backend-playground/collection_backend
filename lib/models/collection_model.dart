import './collection_type_model.dart';

class CollectionModel {
  final String id;
  final String name;
  final String description;
  final DateTime creationDate;
  final DateTime changeDate;
  final CollectionTypeModel type;

  CollectionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.changeDate,
    required this.type,
  });

  factory CollectionModel.empty() {
    return CollectionModel(
      id: '',
      name: '',
      description: '',
      creationDate: DateTime.now(),
      changeDate: DateTime.now(),
      type: CollectionTypeModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'creationDate': creationDate.day,
      'changeDate': changeDate.day,
    };
  }

  static CollectionModel fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: CollectionTypeModel.empty(), //json['type'],
      changeDate: json['changeDate'] ?? DateTime.now(),
      description: json['description'] ?? '',
      creationDate: json['creationDate'] ?? DateTime.now(),
    );
  }
}
