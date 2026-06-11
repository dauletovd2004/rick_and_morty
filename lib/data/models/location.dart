class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;

  const Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json['id'] as int,
        name: json['name'] as String,
        type: json['type'] as String,
        dimension: json['dimension'] as String,
      );
}
