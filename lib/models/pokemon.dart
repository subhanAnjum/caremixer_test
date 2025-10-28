/// Pokemon model
class Pokemon {
  final String name;
  final String url;
  final int id;
  final String imageUrl;

  const Pokemon({
    required this.name,
    required this.url,
    required this.id,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = int.parse(url.split('/').reversed.elementAt(1));

    return Pokemon(
      name: json['name'] as String,
      url: url,
      id: id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}

/// Pokemon API response model
class PokemonResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  const PokemonResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    return PokemonResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List)
          .map((item) => Pokemon.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
