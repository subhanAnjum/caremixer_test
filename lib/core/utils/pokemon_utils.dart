import 'package:flutter/material.dart';

/// Pokemon type utilities
class PokemonUtils {
  /// Get Pokemon type based on ID (simplified mapping)
  static String getPokemonType(int id) {
    // Simplified type mapping based on Pokemon ID ranges
    // In a real app, we'd fetch this from the API
    final typeMap = {
      1: 'Grass',
      2: 'Grass',
      3: 'Grass',
      4: 'Fire',
      5: 'Fire',
      6: 'Fire',
      7: 'Water',
      8: 'Water',
      9: 'Water',
      10: 'Bug',
      11: 'Bug',
      12: 'Bug',
      13: 'Bug',
      14: 'Bug',
      15: 'Bug',
      16: 'Normal',
      17: 'Normal',
      18: 'Normal',
      19: 'Normal',
      20: 'Normal',
      21: 'Normal',
      22: 'Normal',
      23: 'Poison',
      24: 'Poison',
      25: 'Electric',
      26: 'Electric',
      27: 'Ground',
      28: 'Ground',
      29: 'Poison',
      30: 'Poison',
      31: 'Poison',
      32: 'Poison',
      33: 'Poison',
      34: 'Poison',
      35: 'Fairy',
      36: 'Fairy',
      37: 'Fire',
      38: 'Fire',
      39: 'Normal',
      40: 'Normal',
      41: 'Poison',
      42: 'Poison',
      43: 'Grass',
      44: 'Grass',
      45: 'Grass',
      46: 'Bug',
      47: 'Bug',
      48: 'Bug',
      49: 'Bug',
      50: 'Ground',
      51: 'Ground',
      52: 'Normal',
      53: 'Normal',
      54: 'Water',
      55: 'Water',
      56: 'Fighting',
      57: 'Fighting',
      58: 'Fire',
      59: 'Fire',
      60: 'Water',
      61: 'Water',
      62: 'Water',
      63: 'Psychic',
      64: 'Psychic',
      65: 'Psychic',
      66: 'Fighting',
      67: 'Fighting',
      68: 'Fighting',
      69: 'Grass',
      70: 'Grass',
      71: 'Grass',
      72: 'Water',
      73: 'Water',
      74: 'Rock',
      75: 'Rock',
      76: 'Rock',
      77: 'Fire',
      78: 'Fire',
      79: 'Water',
      80: 'Water',
      81: 'Electric',
      82: 'Electric',
      83: 'Normal',
      84: 'Normal',
      85: 'Normal',
      86: 'Water',
      87: 'Water',
      88: 'Poison',
      89: 'Poison',
      90: 'Water',
      91: 'Water',
      92: 'Ghost',
      93: 'Ghost',
      94: 'Ghost',
      95: 'Rock',
      96: 'Psychic',
      97: 'Psychic',
      98: 'Water',
      99: 'Water',
      100: 'Electric',
      101: 'Electric',
      102: 'Grass',
      103: 'Grass',
      104: 'Ground',
      105: 'Ground',
      106: 'Fighting',
      107: 'Fighting',
      108: 'Normal',
      109: 'Poison',
      110: 'Poison',
      111: 'Ground',
      112: 'Ground',
      113: 'Normal',
      114: 'Grass',
      115: 'Normal',
      116: 'Water',
      117: 'Water',
      118: 'Water',
      119: 'Water',
      120: 'Water',
      121: 'Water',
      122: 'Psychic',
      123: 'Bug',
      124: 'Ice',
      125: 'Electric',
      126: 'Fire',
      127: 'Bug',
      128: 'Normal',
      129: 'Water',
      130: 'Water',
      131: 'Water',
      132: 'Normal',
      133: 'Normal',
      134: 'Water',
      135: 'Electric',
      136: 'Fire',
      137: 'Normal',
      138: 'Rock',
      139: 'Rock',
      140: 'Rock',
      141: 'Rock',
      142: 'Rock',
      143: 'Normal',
      144: 'Ice',
      145: 'Electric',
      146: 'Fire',
      147: 'Dragon',
      148: 'Dragon',
      149: 'Dragon',
      150: 'Psychic',
      151: 'Psychic',
    };

    return typeMap[id] ?? 'Normal';
  }

  /// Get Pokemon type color
  static Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF6B6B);
      case 'water':
        return const Color(0xFF4ECDC4);
      case 'grass':
        return const Color(0xFF45B7D1);
      case 'electric':
        return const Color(0xFFFFD93D);
      case 'psychic':
        return const Color(0xFF9B59B6);
      case 'ice':
        return const Color(0xFF74B9FF);
      case 'dragon':
        return const Color(0xFF6C5CE7);
      case 'dark':
        return const Color(0xFF2D3436);
      case 'fairy':
        return const Color(0xFFFFB3E6);
      case 'fighting':
        return const Color(0xFFE17055);
      case 'flying':
        return const Color(0xFF81ECEC);
      case 'poison':
        return const Color(0xFFA29BFE);
      case 'ground':
        return const Color(0xFFDDA0DD);
      case 'rock':
        return const Color(0xFFD2B48C);
      case 'bug':
        return const Color(0xFF26D0CE);
      case 'ghost':
        return const Color(0xFF636E72);
      case 'steel':
        return const Color(0xFFB2BEC3);
      case 'normal':
      default:
        return const Color(0xFFDDD6FE);
    }
  }

  /// Get Pokemon type background gradient
  static LinearGradient getTypeGradient(String type) {
    final color = getTypeColor(type);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.withValues(alpha: 0.1),
        color.withValues(alpha: 0.05),
        color.withValues(alpha: 0.02),
      ],
      stops: const [0.0, 0.6, 1.0],
    );
  }

  /// Get Pokemon type icon
  static IconData getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Icons.local_fire_department;
      case 'water':
        return Icons.water_drop;
      case 'grass':
        return Icons.grass;
      case 'electric':
        return Icons.electric_bolt;
      case 'psychic':
        return Icons.psychology;
      case 'ice':
        return Icons.ac_unit;
      case 'dragon':
        return Icons.pets;
      case 'dark':
        return Icons.dark_mode;
      case 'fairy':
        return Icons.auto_awesome;
      case 'fighting':
        return Icons.sports_mma;
      case 'flying':
        return Icons.flight;
      case 'poison':
        return Icons.science;
      case 'ground':
        return Icons.terrain;
      case 'rock':
        return Icons.landscape;
      case 'bug':
        return Icons.bug_report;
      case 'ghost':
        return Icons.visibility_off;
      case 'steel':
        return Icons.build;
      case 'normal':
      default:
        return Icons.circle;
    }
  }

  /// Format Pokemon name with proper capitalization
  static String formatPokemonName(String name) {
    return name
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// Get Pokemon generation based on ID
  static int getPokemonGeneration(int id) {
    if (id <= 151) return 1;
    if (id <= 251) return 2;
    if (id <= 386) return 3;
    if (id <= 493) return 4;
    if (id <= 649) return 5;
    if (id <= 721) return 6;
    if (id <= 809) return 7;
    if (id <= 905) return 8;
    return 9;
  }
}
