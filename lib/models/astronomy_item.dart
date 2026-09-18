/// Modelo que representa um objeto astronômico no aplicativo Astrova.
///
/// Este modelo é utilizado para armazenar os dados vindos da API REST
/// e trafegar essas informações entre as telas (Explorar -> Detalhes).
class AstronomyItem {
  final String id;
  final String name;
  final String category; // 'Planetas', 'Estrelas', 'Galáxias'
  final String type; // 'PLANETA ROCHOSO', 'GIGANTE GASOSO', etc.
  final String shortDescription;
  final String description;
  final String imageUrl;
  final String distance;
  final String diameter;
  final String curiosity;

  // Construtor principal da classe
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

  /// Construtor de fábrica (factory) para criar uma instância a partir de um Map (JSON).
  ///
  /// Passo a passo didático:
  /// Recebe um `Map<String, dynamic>` (resultado do jsonDecode) e extrai cada campo,
  /// garantindo valores padrão caso algum campo venha nulo.
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

  /// Converte a instância de volta para um Map (útil para serialização).
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
