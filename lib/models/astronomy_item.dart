class AstronomyItem {
  final String id;
  final String name;
  final String category;
  final String type;
  final String shortDescription;
  final String description;
  final String imageUrl;
  final String distance;
  final String diameter;
  final String curiosity;

  const AstronomyItem({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.shortDescription,
    required this.description,
    required this.imageUrl,
    required this.distance,
    required this.diameter,
    required this.curiosity,
  });

  // Requisito: Conversão do JSON da API REST para o modelo AstronomyItem
  factory AstronomyItem.fromJson(Map<String, dynamic> json) {
    return AstronomyItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      distance: json['distance'] ?? '',
      diameter: json['diameter'] ?? '',
      curiosity: json['curiosity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'type': type,
      'shortDescription': shortDescription,
      'description': description,
      'imageUrl': imageUrl,
      'distance': distance,
      'diameter': diameter,
      'curiosity': curiosity,
    };
  }
}
