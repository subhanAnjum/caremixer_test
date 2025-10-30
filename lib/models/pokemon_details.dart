/// Pokemon detailed information model
class PokemonDetails {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> types;
  final List<String> abilities;
  final PokemonStats stats;
  final int height; // in decimeters
  final int weight; // in hectograms
  final String habitat;
  final int generation;
  final List<String> eggGroups;
  final double captureRate;
  final int baseHappiness;

  const PokemonDetails({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.height,
    required this.weight,
    required this.habitat,
    required this.generation,
    required this.eggGroups,
    required this.captureRate,
    required this.baseHappiness,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl:
          json['sprites']['other']['official-artwork']['front_default']
              as String? ??
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['id']}.png',
      description: _getDescription(
        json['flavor_text_entries'] as List<dynamic>?,
      ),
      types: (json['types'] as List<dynamic>)
          .map((type) => (type['type']['name'] as String).toUpperCase())
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map(
            (ability) => (ability['ability']['name'] as String).toUpperCase(),
          )
          .toList(),
      stats: PokemonStats.fromJson(json['stats'] as List<dynamic>),
      height: json['height'] as int,
      weight: json['weight'] as int,
      habitat: json['habitat']?['name'] as String? ?? 'Unknown',
      generation: _getGeneration(json['id'] as int),
      eggGroups: (json['egg_groups'] as List<dynamic>)
          .map((group) => (group['name'] as String).toUpperCase())
          .toList(),
      captureRate: (json['capture_rate'] as int).toDouble(),
      baseHappiness: json['base_happiness'] as int,
    );
  }

  static String _getDescription(List<dynamic>? flavorTextEntries) {
    if (flavorTextEntries == null || flavorTextEntries.isEmpty) {
      return 'No description available.';
    }

    // Find English description
    for (final entry in flavorTextEntries) {
      if (entry['language']['name'] == 'en') {
        return (entry['flavor_text'] as String)
            .replaceAll('\n', ' ')
            .replaceAll('\f', ' ')
            .trim();
      }
    }

    // Fallback to first available description
    return (flavorTextEntries.first['flavor_text'] as String)
        .replaceAll('\n', ' ')
        .replaceAll('\f', ' ')
        .trim();
  }

  static int _getGeneration(int id) {
    if (id <= 151) return 1;
    if (id <= 251) return 2;
    if (id <= 386) return 3;
    if (id <= 493) return 4;
    if (id <= 649) return 5;
    if (id <= 721) return 6;
    if (id <= 809) return 7;
    if (id <= 898) return 8;
    return 9;
  }

  /// Get primary type (first type)
  String get primaryType => types.isNotEmpty ? types.first : 'NORMAL';

  /// Get formatted height in meters
  String get formattedHeight => '${(height / 10).toStringAsFixed(1)}m';

  /// Get formatted weight in kilograms
  String get formattedWeight => '${(weight / 10).toStringAsFixed(1)}kg';

  /// Get formatted capture rate as percentage
  String get formattedCaptureRate =>
      '${(captureRate / 3 * 100).toStringAsFixed(1)}%';
}

/// Pokemon stats model
class PokemonStats {
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  const PokemonStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory PokemonStats.fromJson(List<dynamic> stats) {
    int getStatValue(String statName) {
      for (final stat in stats) {
        if (stat['stat']['name'] == statName) {
          return stat['base_stat'] as int;
        }
      }
      return 0;
    }

    return PokemonStats(
      hp: getStatValue('hp'),
      attack: getStatValue('attack'),
      defense: getStatValue('defense'),
      specialAttack: getStatValue('special-attack'),
      specialDefense: getStatValue('special-defense'),
      speed: getStatValue('speed'),
    );
  }

  /// Get total base stats
  int get total =>
      hp + attack + defense + specialAttack + specialDefense + speed;

  /// Get stat percentage for dial (0.0 to 1.0)
  double getStatPercentage(String statName) {
    final maxStat = 255; // Maximum possible stat value
    final value = _getStatValue(statName);
    return (value / maxStat).clamp(0.0, 1.0);
  }

  int _getStatValue(String statName) {
    switch (statName.toLowerCase()) {
      case 'hp':
        return hp;
      case 'attack':
        return attack;
      case 'defense':
        return defense;
      case 'special-attack':
      case 'sp_attack':
        return specialAttack;
      case 'special-defense':
      case 'sp_defense':
        return specialDefense;
      case 'speed':
        return speed;
      default:
        return 0;
    }
  }
}
