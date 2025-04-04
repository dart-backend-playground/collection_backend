class CollectionTypeModel {
  final String id;
  final String name;
  final String description;
  final DateTime creationDate;
  final DateTime changeDate;

  CollectionTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.changeDate,
  });

  factory CollectionTypeModel.empty() {
    return CollectionTypeModel(
      id: '',
      name: '',
      description: '',
      creationDate: DateTime.now(),
      changeDate: DateTime.now(),
    );
  }
}
